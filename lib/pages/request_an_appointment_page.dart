import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'package:food_to_fit/blocs/requestAnAppointmentBloc.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/main.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class RequestAnAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RequestAnAppointmentForm();
  }
}

class RequestAnAppointmentForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RequestAnAppointmentFormState();
  }
}

class RequestAnAppointmentFormState extends State<RequestAnAppointmentForm> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> meetingTypesList = ['Face to face'.tr(), 'Online'.tr()];
  final Pattern pattern = r'^(0|\+){1}[0-9]{6,15}$';
  String isAuthenticated = " ";
  late RequestAnAppointmentBloc bloc;
  bool loading = false;

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? selectedMeetingType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarWidget().appBarWidget(AutoSizeText("Request an appointment".tr(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          maxFontSize: 16)) as PreferredSizeWidget?,
      body: formSetup(context),
    );
  }

  Widget formSetup(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width / 12),
            padding: EdgeInsets.symmetric(
                vertical: ConstMeasures.borderWidth,
                horizontal: ConstMeasures.borderWidth),
            child: FutureBuilder(
                future: checkAuthentication(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data != null && snapshot.data == false) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
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
                                hintText: "",
                                labelText: "First Name",
                                labelStyle: TextStyle(
                                    color: Colors.grey[600], fontSize: 16)),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.required(),
                            onSaved: (value) => firstName = value,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "",
                              labelText: "Last Name",
                              labelStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(
                                    color: CustomColors.PrimaryColor),
                              ),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.required(),
                            onSaved: (value) => lastName = value,
                          ),
                          SizedBox(height: 20.0),
                          FormBuilderTextField(
                            decoration: InputDecoration(
                              hintText: "",
                              labelText: "Phone Number",
                              labelStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 16.0),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(
                                    color: CustomColors.PrimaryColor),
                              ),
                            ),
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,

                            validator:
                  FormBuilderValidators.compose( [
                    // FormBuilderValidators.numeric(),
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6,
                        errorText:
                        "Phone number must be more than or equal to 6"),
                    FormBuilderValidators.maxLength(15,
                        errorText:
                        "Phone number must be less than or equal to 15"),
                    FormBuilderValidators.match(pattern.toString(),
                        errorText:
                        "Invalid phone number"),
                  ])
                           ,
                            onSaved: ((value) => phoneNumber = value) as void Function(String?)?, name: '',
                          ),
                          SizedBox(height: 20.0),
                          FormBuilderDropdown(
                            decoration: InputDecoration(
                              hintText: "",
                              labelText: "Meeting Type".tr(),
                              labelStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                            ),
                            validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                            items: meetingTypesList
                                .map((meetingType) => DropdownMenuItem(
                                    value: meetingType,
                                    child: Text("$meetingType")))
                                .toList(),
                            onSaved: (dynamic value) => selectedMeetingType = value, name: '',
                          ),
                          SizedBox(height: 20.0),
                          RoundedButton(
                            color: CustomColors.PrimaryColor,
                            textColor: Colors.white,
                            title: 'Send'.tr(),
                            onClick: () async {
                              if (formKey.currentState!.validate()) {
                                if (await checkLastAppointmentRequestDate()) {
                                    formKey.currentState!.save();
                                    sendGuestAppointmentRequest();
                                    await SharedPreferencesSingleton().addStringToSF(SharedPreferencesSingleton.lastAppointmentRequestDate, DateTime.now().toString().split(' ')[0]);
                                  } else {
                                    Future.delayed(Duration.zero, () {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) {
                                            return CustomDialog(
                                              title: ' ',
                                              message:
                                                  'You have sent an appointment for today, please try again later',
                                              backgroundColor: CustomColors
                                                  .ErrorMessageColor,
                                              actionTitle: 'Ok',
                                              onPressed: () {
                                                // formKey.currentState.reset();
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              onCanceled: null,
                                            );
                                          });
                                    });
                                  }
                                }
                              },
                          )
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FormBuilderDropdown(
                            decoration: InputDecoration(
                              hintText: "",
                              labelText: "Meeting Type".tr(),
                              labelStyle: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25.0)),
                                borderSide: BorderSide(color: Colors.grey[400]!),
                              ),
                            ),
                            validator: FormBuilderValidators.compose([FormBuilderValidators.required()]),
                            items: meetingTypesList
                                .map((meetingType) => DropdownMenuItem(
                                    value: meetingType,
                                    child: Text("$meetingType")))
                                .toList(),
                            onSaved: (dynamic value) => selectedMeetingType = value, name: '',
                          ),
                          SizedBox(height: 20.0),
                          RoundedButton(
                            color: CustomColors.PrimaryColor,
                            textColor: Colors.white,
                            title: 'Send'.tr(),
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                sendAuthenticatedAppointmentRequest();
                              }
                            },
                          )
                        ],
                      );
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
          ),
        ),
      ),
      loading
          ? Container(
              child: StreamBuilder<ApiResponse<CommonResponse>>(
                stream: bloc.requestAnAppointmentResponseStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print("data: " + snapshot.data.toString());
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
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return CustomDialog(
                                    title: 'Success:',
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
                        bloc.requestAnAppointmentResponseSink.add(ApiResponse<CommonResponse>());
                        break;
                      case Status.COMPLETED_WITH_FALSE:
                        if (snapshot.data!.data!.message ==
                            "Your account is unauthorized") {
                          logOut(context);
                        }
                        loading = false;
                        print(snapshot.data!.data!.message);
                        print('COMPLETED_WITH_FALSE');
                        Future.delayed(Duration.zero, () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  title: 'Wrong:',
                                  message: snapshot.data!.data!.message,
                                  backgroundColor:
                                      CustomColors.ErrorMessageColor,
                                  actionTitle: 'Ok',
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  onCanceled: null,
                                );
                              });
                        });
                        bloc.requestAnAppointmentResponseSink.add(ApiResponse<CommonResponse>());
                        break;
                      case Status.ERROR:
                        loading = false;
                        Future.delayed(Duration.zero, () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return CustomDialog(
                                  title: 'Wrong:',
                                  message: snapshot.data!.message,
                                  backgroundColor:
                                      CustomColors.ErrorMessageColor,
                                  actionTitle: 'Ok',
                                  onPressed: () => Navigator.pop(context),
                                  onCanceled: null,
                                );
                              });
                        });
                        bloc.requestAnAppointmentResponseSink.add(ApiResponse<CommonResponse>());
                        break;
                    }
                  } else {
                    print("snap shot has no data");
                  }
                  return Container();
                },
              ),
            )
          : Container(),
    ]);
  }

  Future sendGuestAppointmentRequest() async {
    bloc = RequestAnAppointmentBloc(
        phone: phoneNumber,
        meetingType: selectedMeetingType,
        guestName: firstName! + " " + lastName!);

    setState(() => loading = true);
  }

  Future sendAuthenticatedAppointmentRequest() async {
    bloc = RequestAnAppointmentBloc(meetingType: selectedMeetingType);
    setState(() => loading = true);
  }

  Future<bool> checkAuthentication() async {
    return await SharedPreferencesSingleton()
            .getStringValuesSF(SharedPreferencesSingleton.accessToken) !=
        null;
  }

  Future<bool> checkLastAppointmentRequestDate() async {
    String lastAppointmentDateRequest = await SharedPreferencesSingleton().getStringValuesSF(
        SharedPreferencesSingleton.lastAppointmentRequestDate);
    // print("lastAppointmentDateRequest " + lastAppointmentDateRequest);
    if (lastAppointmentDateRequest != "last_appointment_request_date"){
      return lastAppointmentDateRequest != DateTime.now().toString().split(' ')[0];
    } else {
      return false;
    }
  }
}
