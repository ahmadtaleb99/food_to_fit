import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:food_to_fit/pages/guest_home_page.dart';
import 'package:food_to_fit/pages/authenticated_home_page.dart';
import 'package:food_to_fit/resources/app_icons.dart';
import 'package:food_to_fit/pages/profile_page.dart';
import 'package:food_to_fit/pages/visits_page.dart';
import 'package:food_to_fit/pages/diet_programs_page.dart';
import 'package:food_to_fit/pages/med_test_page.dart';
import '../resources/app_constants.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MainPage extends StatefulWidget {
  final isAuthenticated;

  MainPage({required this.isAuthenticated});

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  // ListQueue<int> navigationQueue = ListQueue();
  int selectedIndex = 0;

  // static List<Widget> widgetOptions = <Widget>[
  //   chooseHomeView(),
  //   DietProgramsPage(),
  //   MedTestPage(),
  //   VisitsPage(),
  //   ProfilePage()
  // ];

  List<Widget> widgetOptions = [];

  @override
  initState() {
    super.initState();
    if (widget.isAuthenticated) {
      widgetOptions.add(UserHomeViewWidget());
    } else {
      widgetOptions.add(GuestHomeViewWidget());
    }
    widgetOptions.add(DietProgramsPage());
    widgetOptions.add(MedTestPage());
    widgetOptions.add(VisitsPage());
    widgetOptions.add(ProfilePage());
  }

  static List<String> widgetOptionsTitles = <String>[
    'Home',
    'Diet',
    'Med Test',
    'My visits and payments',
    'Profile'
  ];

   appBarContent() {
    if (selectedIndex == 0)
      return Container(
          width: 144,
          height: 33,
          child: Image.asset('assets/images/text_logo.png'));
    else
      return AutoSizeText(
        widgetOptionsTitles[selectedIndex].tr(),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        maxFontSize: 16,
      );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (selectedIndex == 0) {
          // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return true;
        }
        setState(() {
          selectedIndex = 0;
        });
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: selectedIndex != 0
            ? AppBarWidget().appBarWidget(appBarContent()) as PreferredSizeWidget?
            : AppBarWidget().appBarWidgetWithoutBack(appBarContent()) as PreferredSizeWidget?,
        body: Center(
          child: widgetOptions[selectedIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[300]!, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 10,
              unselectedFontSize: 10,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: showBottomNavigationBarIndicator(
                      selectedIndex == 0, AppIcons.ic_home_1),
                  label: 'Home'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: showBottomNavigationBarIndicator(
                      selectedIndex == 1, AppIcons.watermelon),
                  label: 'Diet'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: showBottomNavigationBarIndicator(
                      selectedIndex == 2, AppIcons.group_358),
                  label: 'Med Test'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: showBottomNavigationBarIndicator(
                      selectedIndex == 3, AppIcons.icon_orders),
                  label: 'Visits'.tr(),
                ),
                BottomNavigationBarItem(
                  icon: showBottomNavigationBarIndicator(
                      selectedIndex == 4, AppIcons.ic_profile),
                  label: 'Profile'.tr(),
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: CustomColors.PrimaryDarkColor,
              unselectedItemColor: CustomColors.GreyColor,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget showBottomNavigationBarIndicator(bool show, IconData icon) {
    return show
        ? Column(children: [
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Icons.brightness_1,
                  size: 5, color: CustomColors.PrimaryDarkColor),
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 2), child: Icon(icon)),
          ])
        : Column(children: [
            Container(
              padding: const EdgeInsets.only(bottom: 4),
              margin: const EdgeInsets.only(bottom: 5),
            ),
            Container(
                padding: const EdgeInsets.only(bottom: 2), child: Icon(icon)),
          ]);
  }
}
