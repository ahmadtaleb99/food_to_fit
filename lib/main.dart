import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './pages/log_in.dart';
import 'pages/started_page.dart';
import 'package:food_to_fit/pages/main_page.dart';
import 'pages/notifications_page.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'models/pushNotificationModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(MaterialApp(
    title: 'Food to Fit',
    theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat'),
    home: AppWidget(),
    routes: <String, WidgetBuilder>{
      '/LogIn': (BuildContext context) => LogInPage()
    },
  ));
}

Future<String> checkStartedPage() async {
  var startedPageWasSeen = await SharedPreferencesSingleton()
      .getBoolValuesSF(SharedPreferencesSingleton.startedPageWasSeen);
  print(startedPageWasSeen.toString());
  if (startedPageWasSeen != null) {
    if (await checkAuthentication()) {
      return 'AUTHENTICATED';
    }
    return 'GUEST';
  }
  return 'FIRST_TIME';
}

Future<bool> checkAuthentication() async {
  return await SharedPreferencesSingleton()
          .getStringValuesSF(SharedPreferencesSingleton.accessToken) !=
      null;
}

Widget chooseFirstPage() {
  return FutureBuilder<String>(
      future: checkStartedPage(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          String? result = snapshot.data;
          if (result == 'AUTHENTICATED') {
            return MainPage(
              isAuthenticated: true,
            );
          } else if (result == 'GUEST') {
            return LogInPage();
          }
          return StartedPage();
        } else {
          return CircularProgressIndicator();
        }
      });
}

logOut(BuildContext context) async {
  await SharedPreferencesSingleton().logOut();
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/LogIn', (Route<dynamic> route) => false);
}

class AppWidget extends StatefulWidget {
  @override
  AppWidgetState createState() => AppWidgetState();
}

class AppWidgetState extends State<AppWidget> {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
       FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var android =  AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS =  IOSInitializationSettings();
    // var initSetttings =  InitializationSettings(android: android, iOS: iOS);
    // flutterLocalNotificationsPlugin.initialize(initSetttings,
    //     onSelectNotification: onSelectNotification);
    //
    // messaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     PushNotification notification = PushNotification.fromJson(message);
    //     showNotification(notification.title, notification.body);
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => NotificationsPage()));
    //   },
    //   // onBackgroundMessage: myBackgroundMessageHandler,
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //     Navigator.push(context,
    //         MaterialPageRoute(builder: (context) => NotificationsPage()));
    //   },
    // );
    //
    // messaging.requestNotificationPermissions(
    //   IosNotificationSettings(
    //     alert: true,
    //     badge: true,
    //     provisional: false,
    //     sound: true,
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return chooseFirstPage();
  }

  // showNotification(String? title, String? content) async {
  //   var android =  AndroidNotificationDetails(
  //       'channel id', 'channel NAME', 'CHANNEL DESCRIPTION' as int?,
  //       priority: Priority.high, importance: Importance.max);
  //   var iOS =  IOSNotificationDetails();
  //   var platform =  NotificationDetails(android: android, iOS: iOS);
  //   await flutterLocalNotificationsPlugin.show(0, title, content, platform,
  //       payload: 'AndroidCoding.in');
  // }

  //  Future onSelectNotification(String? payload) {
  //   print("payload : $payload");
  //   Navigator.push(context,
  //       MaterialPageRoute(builder: (context) => NotificationsPage()));
  // }
}
