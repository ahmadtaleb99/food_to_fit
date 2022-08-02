import 'package:flutter/material.dart';
import './drawables/rounded_text_field.dart';
import './drawables/rounded_button.dart';
import '../app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'package:food_to_fit/blocs/forgetPasswordBloc.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  ForgotPasswordPageState createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController =  TextEditingController();
  late ForgetPasswordBloc bloc;
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
                    mainAxisAlignment: MainAxisAlignment.center,
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 24),
                            RoundedTextField(
                              hint: "Email",
                              obscure: false,
                              controller: emailController,
                              action: TextInputAction.done,
                              textInputType: TextInputType.emailAddress,
                              onSubmitted: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  bloc =
                                      ForgetPasswordBloc(emailController.text);
                                  loading = true;
                                  setState(() {});
                                }
                              },
                            ),
                            SizedBox(height: 20),
                            RoundedButton(
                              color: CustomColors.PrimaryColor,
                              textColor: Colors.white,
                              title: 'Confirm',
                              onClick: () {
                                if (formKey.currentState!.validate()) {
                                  formKey.currentState!.save();
                                  bloc =
                                      ForgetPasswordBloc(emailController.text);
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
                  stream: bloc.forgetPasswordResponseStream,
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
                                      actionTitle: 'Ok',
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      },
                                      onCanceled: null,
                                    );
                                  });
                            });
                          }
                          bloc.forgetPasswordResponseSink.add(ApiResponse<CommonResponse>());
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
                                    title: '',
                                    message: snapshot.data!.data!.message,
                                    backgroundColor:
                                        CustomColors.ErrorMessageColor,
                                    actionTitle: 'Ok',
                                    onPressed: () => Navigator.pop(context),
                                    onCanceled: null,
                                  );
                                });
                          });
                          bloc.forgetPasswordResponseSink.add(ApiResponse<CommonResponse>());
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
                                        bloc = ForgetPasswordBloc(
                                            emailController.text);
                                        loading = true;
                                        setState(() {});
                                      },
                                    onCanceled: null,
                                  );
                                });
                          });
                          bloc.forgetPasswordResponseSink.add(ApiResponse<CommonResponse>());
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
