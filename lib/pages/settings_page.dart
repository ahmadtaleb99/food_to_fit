import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';

enum SingingCharacter { English, Arabic }

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  SingingCharacter? character = SingingCharacter.English;
  bool switchNotificationValue = false;
  bool switchReminderValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget().appBarWidget(AutoSizeText(
          "Settings",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          maxFontSize: 16,
        )) as PreferredSizeWidget?,
        body: SingleChildScrollView(
            child: Container(
                // color: Colors.white,
                // height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              'Choose Languages',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              maxFontSize: 14,
                            ),
                            SizedBox(height: 10.0),
                            AutoSizeText(
                              'Please select your preferred language to facilitate communication',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              maxFontSize: 14,
                            ),
                          ]),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                      title: const AutoSizeText(
                        'English',
                        style: TextStyle(fontSize: 14.0),
                        maxFontSize: 14,
                      ),
                      leading: Container(
                        // color: Colors.red,
                        child: Radio(
                          activeColor: CustomColors.LightLeavesGreen,
                          value: SingingCharacter.English,
                          groupValue: character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                      title: Container(
                        // color: Colors.blue,
                        child: const AutoSizeText(
                          'العربية',
                          style: TextStyle(fontSize: 14.0),
                          maxFontSize: 14,
                        ),
                      ),
                      leading: Container(
                        // color: Colors.red,
                        child: Radio(
                          activeColor: CustomColors.LightLeavesGreen,
                          value: SingingCharacter.Arabic,
                          groupValue: character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              character = value;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      child: AutoSizeText(
                        'Settings',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        maxFontSize: 14,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: ConstMeasures.borderWidth,
                          right: ConstMeasures.borderWidth),
                      title: const AutoSizeText(
                        'Allow Notifications',
                        style: TextStyle(fontSize: 14.0),
                        maxFontSize: 14,
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: CustomColors.LightGreenColor,
                        value: switchNotificationValue,
                        onChanged: (value) {
                          setState(() {
                            switchNotificationValue = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConstMeasures.borderWidth),
                      child: Divider(
                        color: CustomColors.GreyDividerColor,
                        thickness: 3.0,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: ConstMeasures.borderWidth,
                          right: ConstMeasures.borderWidth),
                      title: const AutoSizeText(
                        'Allow Reminders',
                        style: TextStyle(fontSize: 14.0),
                        maxFontSize: 14,
                      ),
                      trailing: CupertinoSwitch(
                        activeColor: CustomColors.LightGreenColor,
                        value: switchReminderValue,
                        onChanged: (value) {
                          setState(() {
                            switchReminderValue = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConstMeasures.borderWidth),
                      child: Divider(
                        color: CustomColors.GreyDividerColor,
                        thickness: 3.0,
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      child: RoundedButton(
                        color: CustomColors.PrimaryColor,
                        textColor: Colors.white,
                        title: 'Update',
                        onClick: (){},
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ))));
  }
}
