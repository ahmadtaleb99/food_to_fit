import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/models/profileActionWidgetModel.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/resources/app_icons.dart';
import 'package:food_to_fit/pages/change_password_page.dart';
import 'package:food_to_fit/pages/notifications_page.dart';
import 'package:food_to_fit/pages/profile_info_page.dart';
import 'package:food_to_fit/pages/settings_page.dart';
import 'package:food_to_fit/pages/switch_patient_page.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/profileActionWidget.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'dart:io';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/blocs/getBasicProfileInfoBloc.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';

import '../resources/language_manager.dart';

bool loading = false;
String imageURL = " ";
// "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80";
Image image = Image.network(
  imageURL,
  fit: BoxFit.contain,
);

File? imageFile;

class ProfilePage extends StatefulWidget {
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  bool loggingOut = false;
  ProfileInfo? profile;
  String _selectedLanguage='';
    bool _loading= false;
  @override
  void initState() {
    _selectedLanguage = getIT<AppPreferences>().getAppLanguage();
    super.initState();
    image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool syncCall) => setState(() {
              loading = true;
            })));
  }

  @override
  Widget build(BuildContext context) {
    log('build');
    GetBasicProfileBloc bloc = GetBasicProfileBloc();
    return FutureBuilder(
        future: checkAuthentication(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!= null && snapshot.data == true) {
              return Scaffold(
                body: Stack(children: [
                  Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: RefreshIndicator(
                      onRefresh: () => bloc.fetchResponse(),
                      child: StreamBuilder<ApiResponse<CommonResponse>>(
                        stream: bloc.getBasicProfileResponseStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            switch (snapshot.data!.status) {
                              case Status.LOADING :
                                return Center(
                                  child: Loading(),
                                );
                                break;
                              case Status.COMPLETED_WITH_TRUE:
                                profile = snapshot.data!.data!.data;
                                print('COMPLETED_WITH_TRUE');
                                print(snapshot.data!.data!.data);
                                return Center(
                                  child: Container(
                                    color: Colors.white,
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                            ConstMeasures.borderWidth),
                                        child: Column(children: <Widget>[
                                          Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                Container(
                                                    width: 100,
                                                    height: 100,
                                                    child:
                                                        viewImageFromGallery()),
                                                //   loading
                                                //       ? Container(
                                                //           decoration: BoxDecoration(
                                                //               borderRadius: BorderRadius.circular(
                                                //                   ConstMeasures.borderCircular),
                                                //               image: DecorationImage(
                                                //                   image: NetworkImage(imageURL),
                                                //                   fit: BoxFit.fill)),
                                                //         )
                                                //       : Card(
                                                //           elevation: 5.0,
                                                //           shape: RoundedRectangleBorder(
                                                //             borderRadius: BorderRadius.circular(
                                                //                 ConstMeasures.borderCircular),
                                                //           ),
                                                //           child: Container(
                                                //               margin: EdgeInsets.all(20),
                                                //               child: Icon(AppIcons.user,
                                                //                   color: CustomColors.GreyColor, size: 40))),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     getFromGallery();
                                                //   },
                                                //   child: Container(
                                                //     decoration: BoxDecoration(
                                                //         color: CustomColors.PrimaryColor,
                                                //         shape: BoxShape.circle),
                                                //     child: Icon(
                                                //       Icons.add,
                                                //       color: Colors.white,
                                                //     ),
                                                //   ),
                                                // )
                                              ]),
                                          SizedBox(height: 10),
                                          Text(
                                            profile!.profile!.firstName! +
                                                " " +
                                                profile!.profile!.lastName!,
                                            style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          profile!.account!.email != null ? Text(
                                            profile!.account!.email!,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ) : Container(),
                                          SizedBox(height: 10),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            decoration: BoxDecoration(
                                                color:
                                                    CustomColors.LightGreyColor,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(25),
                                                )),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Icon(
                                                  AppIcons.ic_call,
                                                  size: 20,
                                                  color:
                                                      CustomColors.PrimaryColor,
                                                ),
                                                SizedBox(width: 5),
                                                Text(profile!.account!.phone!,
                                                    style: TextStyle(
                                                        fontSize: 13.0))
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Column(
                                            children:[
                                              ProfileActionWidget(title: 'Profile Info', icon: AppIcons.icon_user, onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileInfoPage()));
                                              },),
                                              ProfileActionWidget(title: 'Notifications', icon: Icons.notifications_none_outlined, onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsPage()));
                                              },),
                                              ProfileActionWidget(title: 'Account Settings', icon: AppIcons.settings, onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage(profile!.account!))).then((value) => setState((){}));
                                              },),
                                              ProfileActionWidget(title: 'Change Password', icon: Icons.lock_outline, onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChangePasswordPage()));
                                              },),
                                         profile!.patientsCount! > 1 ?    ProfileActionWidget(title: 'Switch Patient', icon: Icons.swap_horiz_rounded, onTap: () {
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => SwitchPatientsPage()));
                                              },) : Container(),

                                            ]
                                            // children: profileActions
                                            //     .map((profileAction) =>
                                            //         ProfileActionWidget(actionWidgetObject: profileAction,)
                                            // )
                                            //     .toList(),
                                          ),
                                          SizedBox(height: 30),
                                          RoundedButton(
                                            color: CustomColors.PrimaryColor,
                                            textColor: Colors.white,
                                            title: 'LOGOUT'.tr(),
                                            onClick: () {
                                              Future.delayed(Duration.zero, () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {

                                                      log('opend');
                                                      return CustomDialog(
                                                        title: ' ',
                                                        backgroundColor:
                                                            CustomColors
                                                                .ErrorMessageColor,
                                                        message:
                                                            'logout-confirm'.tr(),
                                                        actionTitle: 'Ok'.tr(),
                                                        onPressed: () {
                                                          loggingOut = true;
                                                          setState(() {});
                                                          logOut(context);
                                                        },
                                                        onCanceled: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      );
                                                    });
                                              });
                                            },
                                          ),
                                          SizedBox(height: 10),
                                        ]),
                                      ),
                                    ),
                                  ),
                                );
                                break;
                              case Status.ERROR:
                                print('error');
                                return CustomErrorWidget(
                                  errorMessage: snapshot.data!.message,
                                  onRetryPressed: () => bloc.fetchResponse(),
                                );
                                break;
                              case Status.COMPLETED_WITH_FALSE:
                                if(snapshot.data!.data!.message == "Your account is unauthorized"){
                                  logOut(context);
                                }
                                break;
                            }
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  loggingOut ? LoaderWidget() : Container(),
                ]),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15,),
                    Container(
                            padding: EdgeInsets.symmetric(horizontal: 30),
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
                            RadioListTile(
                              contentPadding: EdgeInsets.zero,
                              activeColor: CustomColors.LightLeavesGreen,

                              title:  AutoSizeText(
                                'English'.tr(),

                                style: TextStyle(fontSize: 14.0),
                                maxFontSize: 14,
                              ),
                              groupValue: _selectedLanguage,
                              onChanged: (String? value) {
                                setState(() async {

                                  _selectedLanguage = value!;
                                  await      getIT<AppPreferences>().changeAppLanguage(context, _selectedLanguage);
                                });
                              }, value: LanguageType.ENGLISH.getValue(),

                            ),
                            RadioListTile(
                              contentPadding: EdgeInsets.zero,

                              activeColor: CustomColors.LightLeavesGreen,

                              title:  AutoSizeText(
                                'Arabic'.tr(),

                                style: TextStyle(fontSize: 14.0),
                                maxFontSize: 14,
                              ),
                              groupValue: _selectedLanguage,
                              onChanged: (String? value) {
                                setState(() async {
                                  _selectedLanguage = value!;
                             await      getIT<AppPreferences>().changeAppLanguage(context, _selectedLanguage);

                                });
                              }, value: LanguageType.ARABIC.getValue(),

                            ),
                            RadioListTile(
                              contentPadding: EdgeInsets.zero,

                              activeColor: CustomColors.LightLeavesGreen,

                              title:  AutoSizeText(
                                'Portuguese'.tr(),

                                style: TextStyle(fontSize: 14.0),
                                maxFontSize: 14,
                              ),
                              groupValue: _selectedLanguage,
                              onChanged: (String? value) {
                                setState(() async {
                                  _selectedLanguage = value!;
                             await      getIT<AppPreferences>().changeAppLanguage(context, _selectedLanguage);

                                });
                              }, value: LanguageType.PORTUGUESE.getValue(),

                            ),
                          ]),
                    ),
                    CustomDialog(
                      title: ' ',
                      backgroundColor: CustomColors.ErrorMessageColor,
                      message:
                      ConstMeasures.unAuthenticatedMessage.tr(),
                      actionTitle: 'Go to login'.tr(),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/LogIn', (Route<dynamic> route) => false);
                      },
                    ),
                  ],
                ),
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }
}

Widget viewImageFromGallery() {
  if (imageFile != null) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ConstMeasures.borderCircular),
        image: DecorationImage(
          image: FileImage(imageFile!),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
              color: CustomColors.GreyBorderColor,
              offset: Offset(1, 1),
              blurRadius: 1.0,
              spreadRadius: 1.0)
        ],
      ),
    );
  } else {
    if (loading) {
      return Hero(
        tag: 'profileImage',
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConstMeasures.borderCircular),
            image: DecorationImage(
                image: NetworkImage(imageURL), fit: BoxFit.fill),
            boxShadow: [
              BoxShadow(
                  color: CustomColors.GreyBorderColor,
                  offset: Offset(1, 1),
                  blurRadius: 1.0,
                  spreadRadius: 1.0)
            ],
          ),
        ),
      );
    } else {
      Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ConstMeasures.borderCircular),
          ),
          child: Container(
              margin: EdgeInsets.all(20),
              child: Icon(AppIcons.user,
                  color: CustomColors.GreyColor, size: 40)));
    }
  }
  return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConstMeasures.borderCircular),
      ),
      child: Container(
          margin: EdgeInsets.all(20),
          child: Icon(AppIcons.user, color: CustomColors.GreyColor, size: 40)));
}

logOut(BuildContext context) async {
  await SharedPreferencesSingleton().logOut();
  Navigator.of(context)
      .pushNamedAndRemoveUntil('/LogIn', (Route<dynamic> route) => false);
}

Future<bool> checkAuthentication() async {
  return await SharedPreferencesSingleton()
          .getStringValuesSF(SharedPreferencesSingleton.accessToken) !=
      null;
}
