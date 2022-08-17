import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:food_to_fit/pages/main_page.dart';
import 'package:food_to_fit/pages/profile_info_page.dart';
import 'package:food_to_fit/pages/profile_page.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/profileActionWidget.dart';

import 'change_password_page.dart';

enum SingingCharacter { English, Arabic }

class SettingsPage extends StatefulWidget {
  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  @override
  initState(){
        _selectedLanguage = getIT<AppPreferences>().getAppLanguage();


    super.initState();
  }
  SingingCharacter? character = SingingCharacter.English;
  String _selectedLanguage =' ';

  bool switchNotificationValue = false;
  bool switchReminderValue = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget().appBarWidget(AutoSizeText(
          'Settings'.tr(),
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
                              'Choose Languages'.tr(),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              maxFontSize: 14,
                            ),
                            SizedBox(height: 10.0),
                            AutoSizeText(
                              'select-lang'.tr(),
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              maxFontSize: 14,
                            ),
                          ]),
                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                      activeColor: CustomColors.LightLeavesGreen,

                      title:  AutoSizeText(
                        'English'.tr(),

                        style: TextStyle(fontSize: 14.0),
                        maxFontSize: 14,
                      ),
                      groupValue: _selectedLanguage,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      }, value: LanguageType.ENGLISH.getValue(),

                    ),
                    RadioListTile(
                      contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                      activeColor: CustomColors.LightLeavesGreen,

                      title:  AutoSizeText(
                        'Arabic'.tr(),

                        style: TextStyle(fontSize: 14.0),
                        maxFontSize: 14,
                      ),
                      groupValue: _selectedLanguage,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedLanguage = value!;
                        });
                      }, value: LanguageType.ARABIC.getValue(),

                    ),
                    SizedBox(height: 30),
                    Container(
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      child: AutoSizeText(
                        'Settings'.tr(),
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        maxFontSize: 14,
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.only(
                          left: ConstMeasures.borderWidth,
                          right: ConstMeasures.borderWidth),
                      title:  AutoSizeText(
                        'Allow Notifications'.tr(),
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
                      title:  AutoSizeText(
                        'Allow Reminders'.tr(),
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
                    SizedBox(height: 50,),


                    Container(
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      child: RoundedButton(
                        color: CustomColors.PrimaryColor,
                        textColor: Colors.white,
                        title: 'Update'.tr(),
                        onClick: (){
                          setState(() =>
                              getIT<AppPreferences>().changeAppLanguage(context, _selectedLanguage)
                              .then((value) {
                                Navigator.pop(context,true);
                              }
                          ));
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                ))));
  }
}
