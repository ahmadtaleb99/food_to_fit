import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/models/WelcomeMessage.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/pages/multi_patient_page.dart';
import 'package:food_to_fit/widgets/di.dart';
import './drawables/rounded_text_field.dart';
import './drawables/rounded_button.dart';
import '../resources/app_constants.dart';
import './main_page.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:food_to_fit/pages/forgot_password_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/blocs/logInBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'main_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class LogInPage extends StatefulWidget {
  @override
  LogInPageState createState() => LogInPageState();
}

class LogInPageState extends State<LogInPage> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  late LogInBloc bloc;
  TextEditingController usernameController =  TextEditingController();
  TextEditingController passwordController =  TextEditingController();
  bool loading = false;

   var  _appPrefs =  getIT<AppPreferences>();
  @override
  void initState() {
    usernameController.text = 'hani1@gmail.com';
    passwordController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/log_in_background@2x.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            50, MediaQuery.of(context).size.height / 5, 50, 20),
                        child: CircleAvatar(
                          radius: 105,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            backgroundImage:
                                AssetImage("assets/images/22@2x.png"),
                          ),
                        )),
                    SizedBox(height: 10),
                    AutoSizeText(
                      'Welcome to Food to Fit App'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      minFontSize: 16.0,
                    ),
                    SizedBox(height: 10),
                    Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.all(ConstMeasures.borderWidth),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(25.0),
                              topRight: const Radius.circular(25.0),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 28),
                            RoundedTextField(
                              hint: "Email or Phone".tr(),
                              obscure: false,
                              controller: usernameController,
                              action: TextInputAction.next,
                              textInputType: TextInputType.emailAddress,
                            ),
                            SizedBox(height: 20),
                            RoundedTextField(

                              hint: "password_hint".tr(),
                              obscure: true,
                              controller: passwordController,
                              action: TextInputAction.done,
                              onSubmitted: () async {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  bloc = LogInBloc(
                                      usernameController.text,
                                      passwordController.text,
                                  );
                                  loading = true;
                                  setState(() {});
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            RoundedButton(
                              color: CustomColors.PrimaryColor,
                              textColor: Colors.white,
                              title: 'Log in'.tr(),
                              onClick: () async {
                                // logIn('accessToken', context);
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  FocusScope.of(context).unfocus();
                                  bloc = LogInBloc(
                                      usernameController.text,
                                      passwordController.text,
                                   );
                                  loading = true;
                                  setState(() {});
                                }
                              },
                            ),
                            RoundedButton(
                              color: CustomColors.PrimaryAssentColor,
                              textColor: Colors.white,
                              title: 'Skip'.tr(),
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage(
                                              isAuthenticated: false,
                                            )));
                              },
                            ),
                            SizedBox(height: 15),
                            // Material(
                            //   child: InkWell(
                            //       onTap: () {
                            //         Navigator.of(context).push(
                            //             MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     ForgotPasswordPage()));
                            //       },
                            //       child: Container(
                            //           padding: EdgeInsets.all(12.0),
                            //           child: AutoSizeText(
                            //             'Forgotten password?',
                            //             style: TextStyle(color: Colors.blue),
                            //             minFontSize: 14.0,
                            //           ))),
                            //   color: Colors.white,
                            // ),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          ),
        ),
        loading
            ? Container(
                child: StreamBuilder<ApiResponse<CommonResponse>>(
                  stream: bloc.logInResponseStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      switch (snapshot.data!.status) {
                        case Status.LOADING:
                          return LoaderWidget();
                          break;
                        case Status.COMPLETED_WITH_TRUE:
                          loading = false;
                          print(snapshot.data!.data);
                          print('COMPLETED_WITH_TRUE');
                          if (snapshot.data!.data!.status!) {
                            CommonResponse response = snapshot.data!.data!;
                            if (response.patientsAccounts!.length == 1 )
                              logIn(response, context);
                            else
                            if (response.patientsAccounts!.length > 1 )
                                  _goToMultiPatientPage(response, context);

                                else
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                        title: 'NO patient'.tr(),
                                        backgroundColor:
                                        CustomColors.ErrorMessageColor,
                                        message: 'There is no patient to login'.tr(),
                                        actionTitle: 'Ok'.tr(),
                                        onPressed: () => Navigator.pop(context),
                                        onCanceled: null,
                                      );
                                    });
                              });
                          }
                          bloc.logInResponseSink.add(ApiResponse<CommonResponse>());
                          break;
                        case Status.COMPLETED_WITH_FALSE:
                          loading = false;
                          print(snapshot.data!.data!.message);
                          print('COMPLETED_WITH_FALSE');
                          Future.delayed(Duration.zero, () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    title: 'Wrong:'.tr(),
                                    backgroundColor:
                                        CustomColors.ErrorMessageColor,
                                    message: snapshot.data!.data?.message?.tr(),
                                    actionTitle: 'Ok'.tr(),
                                    onPressed: () => Navigator.pop(context),
                                    onCanceled: null,
                                  );
                                });
                          });
                          bloc.logInResponseSink.add(ApiResponse<CommonResponse>());
                          break;


                        case Status.COMPLETED_WITH_INTERNAL_ERROR:
                          loading = false;
                          print(snapshot.data!.data!.message);
                          print('COMPLETED_WITH_INTERNAL_ERROR');
                         if(snapshot.data!.message == 'firebase-error') {
                           CommonResponse response = snapshot.data!.data!;
                           _saveLoginInformation(response).then((value) =>Navigator.pushAndRemoveUntil(
                               context,
                               MaterialPageRoute(
                                   builder: (context) => MainPage(isAuthenticated: true,welcomeMessage: WelcomeMessage(message: 'notifications-disabled'.tr(), isError: true),)),
                                   (route) => false) );


                         }

                          bloc.logInResponseSink.add(ApiResponse<CommonResponse>());
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
                                      actionTitle: 'Retry'.tr(),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        bloc = LogInBloc(
                                            usernameController.text,
                                            passwordController.text,
                                            );
                                        loading = true;
                                        setState(() {});
                                      },
                                      onCanceled: () => Navigator.pop(context));
                                });
                          });
                          bloc.logInResponseSink.add(ApiResponse<CommonResponse>());
                          break;
                      }
                    }
                    return Container();
                  },
                ),
              )
            : Container(),
      ]),
    );
  }


  Future _saveLoginInformation(CommonResponse response,) async {
    await _appPrefs.saveAccessToken(response.accessToken!);
    await SharedPreferencesSingleton().addStringToSF(
        SharedPreferencesSingleton.accessToken, response.accessToken!);

    await _appPrefs.savePatientId(response.patientsAccounts![0].id.toString());
  }
  logIn(CommonResponse response, BuildContext context) async {

      _saveLoginInformation(response);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MainPage(isAuthenticated: true,)),
        (route) => false);


  }




  _goToMultiPatientPage(CommonResponse response, BuildContext context) async {

    _saveLoginInformation(response);

   await _appPrefs.savePatientId(response.patientsAccounts![0].id.toString());


    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => MultiPatientPage(patients: response.patientsAccounts ?? [ ],email : usernameController.text)),
            (route) => false);
  }
}
