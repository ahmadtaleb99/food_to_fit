import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/blocs/updateAccountSettingsBloc.dart';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/resources/extesnsions.dart';

import 'package:food_to_fit/pages/visit_details_page.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:food_to_fit/pages/main_page.dart';
import 'package:food_to_fit/pages/profile_info_page.dart';
import 'package:food_to_fit/pages/profile_page.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/profileActionWidget.dart';
import 'package:shimmer/shimmer.dart';

import 'change_password_page.dart';

enum SingingCharacter { English, Arabic }

class SettingsPage extends StatefulWidget {
  final Account account;

  SettingsPage(this.account);

  @override
  SettingsPageState createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  UpdateAccountSettingsBloc bloc = UpdateAccountSettingsBloc();

  @override
  initState(){
        // _selectedLanguage = getIT<AppPreferences>().getAppLanguage();

        switchNotificationValue = widget.account.areNotificationsAllowed!.isOdd;
        _selectedLanguage = widget.account.language ?? LanguageType.ENGLISH.getValue();
        log('selected language '+_selectedLanguage.toString());
    super.initState();
  }
  SingingCharacter? character = SingingCharacter.English;
  String _selectedLanguage =' ';
  bool _loading = false;
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
        body: Stack(
          children: [
            SingleChildScrollView(
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
                      RadioListTile(
                        contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                        activeColor: CustomColors.LightLeavesGreen,

                        title:  AutoSizeText(
                          'Portuguese'.tr(),

                          style: TextStyle(fontSize: 14.0),
                          maxFontSize: 14,
                        ),
                        groupValue: _selectedLanguage,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedLanguage = value!;
                          });
                        }, value: LanguageType.PORTUGUESE.getValue(),

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
                        onTap: (){
                          setState(() {
                            switchNotificationValue = !switchNotificationValue;
                          });

                        },
                        contentPadding: EdgeInsets.only(
                            left: ConstMeasures.borderWidth,
                            right: ConstMeasures.borderWidth),
                        title:  AutoSizeText(
                          'Allow Notifications'.tr(),
                          style: TextStyle(fontSize: 14.0),
                          maxFontSize: 14,
                        ),
                        trailing: IgnorePointer(
                          child: CupertinoSwitch(
                            activeColor: CustomColors.LightGreenColor,
                            value:   switchNotificationValue ,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      // Container(
                      //   padding: EdgeInsets.symmetric(
                      //       horizontal: ConstMeasures.borderWidth),
                      //   child: Divider(
                      //     color: CustomColors.GreyDividerColor,
                      //     thickness: 3.0,
                      //   ),
                      // ),
                      // ListTile(
                      //   contentPadding: EdgeInsets.only(
                      //       left: ConstMeasures.borderWidth,
                      //       right: ConstMeasures.borderWidth),
                      //   title:  AutoSizeText(
                      //     'Allow Reminders'.tr(),
                      //     style: TextStyle(fontSize: 14.0),
                      //     maxFontSize: 14,
                      //   ),
                      //   trailing: CupertinoSwitch(
                      //     activeColor: CustomColors.LightGreenColor,
                      //     value: switchReminderValue,
                      //     onChanged: (value) {
                      //       setState(() {
                      //         switchReminderValue = value;
                      //       });
                      //     },
                      //   ),
                      // ),
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
    setState(() {
      _loading= true;
      bloc.fetchResponse
        (Account(areNotificationsAllowed: switchNotificationValue.toInt(),language: _selectedLanguage));

      getIT<AppPreferences>().changeAppLanguage(context, _selectedLanguage);

    });

                            // .then((value) {
                            //   Navigator.pop(context,true);
                            // }
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  )),
            ),
            _loading ?   StreamBuilder<ApiResponse<CommonResponse>>(
                stream: bloc.updateAccountResponseStream,
                builder: (context, snapshot) {
                  return Builder(builder: (context){
                    if (snapshot.hasData)
                      switch (snapshot.data!.status) {
                        case Status.LOADING:
                          return LoaderWidget();
                        case Status.COMPLETED_WITH_TRUE:
                          loading = false;
                          print(snapshot.data!.data);
                          print('COMPLETED_WITH_TRUE');
                          if (snapshot.data!.data!.status!) {
                            Future.delayed(Duration.zero, () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      title: '',
                                      message: snapshot.data!.data?.message!.tr(),
                                      backgroundColor:
                                      CustomColors.SuccessMessageColor,
                                      actionTitle: 'Ok'.tr(),
                                      onPressed: () {
                                        // _loading = false;
                                        // setState(() {});

                                        Navigator.pop(context);
                                      },
                                      onCanceled: null,
                                    );
                                  });
                            });
                          }
                          bloc.updateAccountResponseSink.add(ApiResponse<CommonResponse>());
                          break;
                        case Status.COMPLETED_WITH_FALSE:
                          loading = false;
                          print(snapshot.data!.data!.message);
                          print('COMPLETED_WITH_FALSE');
                          if (snapshot.data!.data!.message ==
                              "Your account is unauthorized") {
                            logOut(context);
                          }
                          Future.delayed(Duration.zero, () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    title: '',
                                    message: snapshot.data!.data!.message,
                                    backgroundColor:
                                    CustomColors.ErrorMessageColor,
                                    actionTitle: 'Ok'.tr(),
                                    onPressed: () => Navigator.pop(context),
                                    onCanceled: null,
                                  );
                                });
                          });
                          bloc.updateAccountResponseSink.add(ApiResponse<CommonResponse>());
                          break;
                        case Status.ERROR:
                          loading = false;
                          Future.delayed(Duration.zero, () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    title: '',
                                    message: snapshot.data!.message,
                                    backgroundColor:
                                    CustomColors.ErrorMessageColor,
                                    actionTitle: 'Retry',
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // bloc = ChangePasswordBloc(
                                      // newPasswordController.text);
                                      // loading = true;
                                      // setState(() {});
                                    },
                                    onCanceled: () {
                                      // _loading = false;
                                      // setState(() {});

                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          });
                          break;
                      }
                    return Container();
                  });
                }
            ) : Container()
          ],
        ));
  }
}
