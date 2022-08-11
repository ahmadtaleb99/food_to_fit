import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import './drawables/rounded_button.dart';
import '../app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'package:food_to_fit/blocs/changePasswordBloc.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/main.dart';

class ChangePasswordPage extends StatefulWidget {
  @override
  ChangePasswordPageState createState() => ChangePasswordPageState();
}

class ChangePasswordPageState extends State<ChangePasswordPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController newPasswordController =  TextEditingController();
  TextEditingController confirmPasswordController =  TextEditingController();
  late ChangePasswordBloc bloc;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Form(
              key: formKey,
              child: Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.fromLTRB(50,
                              MediaQuery.of(context).size.height / 5, 50, 20),
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
                        'Food to Fit App',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        minFontSize: 16.0,
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(25.0),
                              topRight: const Radius.circular(25.0),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 10),
                            Text('Change your password'.tr(),
                                style: TextStyle(fontSize: 16.0, color: Colors.grey, fontWeight: FontWeight.bold)),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 30),
                            TextFormField(
                              controller: newPasswordController,
                              obscureText: true,
                              textInputAction: TextInputAction.next,
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'Field is required'.tr();
                                // if (newPasswordController.text.length < 8)
                                //   return 'Password must be more than or equal to 8';
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide: BorderSide(
                                      color: CustomColors.PrimaryColor),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                                hintText: "New Password".tr(),
                              ),
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: confirmPasswordController,
                              obscureText: true,
                              textInputAction: TextInputAction.done,
                              onFieldSubmitted: (val) {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context)
                                      .requestFocus( FocusNode());
                                  formKey.currentState!.save();
                                  bloc = ChangePasswordBloc(
                                      newPasswordController.text);
                                  loading = true;
                                  setState(() {});
                                }
                              },
                              validator: (val) {
                                if (val!.isEmpty)
                                  return 'Field is required'.tr();
                                if (val != newPasswordController.text)
                                  return 'Confirm does not match with password!'.tr();
                                return null;
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide:
                                      BorderSide(color: Colors.grey[400]!),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25.0)),
                                  borderSide: BorderSide(
                                      color: CustomColors.PrimaryColor),
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey[400], fontSize: 14.0),
                                hintText: "Confirm Password".tr() ,
                              ),
                            ),
                            SizedBox(height: 20),
                            RoundedButton(
                              color: CustomColors.PrimaryColor,
                              textColor: Colors.white,
                              title: 'Change Password'.tr(),
                              onClick: () {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(context)
                                      .requestFocus( FocusNode());
                                  formKey.currentState!.save();
                                  bloc = ChangePasswordBloc(
                                      newPasswordController.text);
                                  loading = true;
                                  setState(() {});
                                }
                              },
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ),
        loading
            ? Container(
                child: StreamBuilder<ApiResponse<CommonResponse>>(
                  stream: bloc.changePasswordResponseStream,
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
                            Future.delayed(Duration.zero, () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      title: '',
                                      message: snapshot.data!.data!.message,
                                      backgroundColor:
                                          CustomColors.SuccessMessageColor,
                                      actionTitle: 'Ok'.tr(),
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      onCanceled: null,
                                    );
                                  });
                            });
                          }
                          bloc.changePasswordResponseSink.add(ApiResponse<CommonResponse>());
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
                          bloc.changePasswordResponseSink.add(ApiResponse<CommonResponse>());
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
                                      bloc = ChangePasswordBloc(
                                          newPasswordController.text);
                                      loading = true;
                                      setState(() {});
                                    },
                                    onCanceled: () {
                                      Navigator.pop(context);
                                    },
                                  );
                                });
                          });
                          bloc.changePasswordResponseSink.add(ApiResponse<CommonResponse>());
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
}
