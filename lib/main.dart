import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/pages/splash_page.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import './pages/log_in.dart';
import 'pages/started_page.dart';
import 'package:food_to_fit/pages/main_page.dart';
import 'pages/notifications_page.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:flutter/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'models/pushNotificationModel.dart';
import 'widgets/errorWidget.dart';
Future backgroundMessageHandler(RemoteMessage message) async {
  print("onBackgroundMessage: $message");
  PushNotification notification = PushNotification.fromJson(message.data);
  AppWidgetState().showNotification(
      notification.title, notification.body);
}

  bool firebaseError= false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


  FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  await initAppModule();
  // try{
  //   await FirebaseMessaging.instance.getToken();
  //
  // } catch (e){
  //   log('firebase error');
  // }


  runApp(EasyLocalization(
    supportedLocales: const [AppLanguages.englishLocale,AppLanguages.arabicLocale,AppLanguages.portugueseLocale],
    path:'assets/languages',

    child: Builder(
      builder: (context) {
        return MaterialApp(

          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Food to Fit',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              fontFamily: 'Montserrat'),
          home:  AppWidget(),
          routes: <String, WidgetBuilder>{
            '/LogIn': (BuildContext context) => LogInPage()
          },
        );
      }
    ),
  ));
}


Future<String> checkStartedPage() async {
  return '';
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
    super.initState();

    var android =  AndroidInitializationSettings('@mipmap/launcher_icon');
    var iOS =  IOSInitializationSettings();
    var initSetttings =  InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
    if(Platform.isIOS) _initNotificationsConfigsIOS();



    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("onMessage: $message");

      // PushNotification notification = PushNotification.fromJson(message.notification.t);
      showNotification(
          message.notification?.title, message.notification?.body);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsPage()));
    });



    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("onResume: $message");
      // PushNotification notification = PushNotification.fromJson(message.data);
      showNotification(
          message.notification?.title, message.notification?.body);

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationsPage()));
    });



  }

  @override
  Widget build(BuildContext context) {
    return SplashPage();

  }

  showNotification(String? title, String? content) async {
    var android =  AndroidNotificationDetails(
        'channel id', 'channel NAME', channelDescription: 'CHANNEL DESCRIPTION',
        priority: Priority.high, importance: Importance.max,styleInformation: BigTextStyleInformation(''));
    var iOS =  IOSNotificationDetails();
    var platform =  NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(0, title, content, platform,
        payload: 'AndroidCoding.in');
  }

   void onSelectNotification(String? payload) {
    print("payload : $payload");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotificationsPage()));
  }

  Future _initNotificationsConfigsIOS() async{
      final fcm = FirebaseMessaging.instance;
    await fcm.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

      fcm.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true );
  }

}
