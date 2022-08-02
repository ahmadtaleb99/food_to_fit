import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AskAQuestion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AskAQuestionForm();
  }
}

class AskAQuestionForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AskAQuestionFormState();
  }
}

class AskAQuestionFormState extends State<AskAQuestionForm> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? question;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarWidget().appBarWidget(Text("Ask a question",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16))) as PreferredSizeWidget?,
      body: formSetup(context),
    );
  }

  SingleChildScrollView formSetup(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width/12),
          padding: EdgeInsets.symmetric(vertical: ConstMeasures.borderWidth, horizontal: ConstMeasures.borderWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: CustomColors.PrimaryColor),
                    ),
                    hintText: "",
                    labelText: "First Name",
                    labelStyle: TextStyle(color: Colors.grey[600])),
                keyboardType: TextInputType.name,
                validator: FormBuilderValidators.required(),
                onSaved: (value) => firstName = value,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "Last Name",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: CustomColors.PrimaryColor),
                  ),
                ),
                keyboardType: TextInputType.name,
                validator: FormBuilderValidators.required(),
                onSaved: (value) => lastName = value,
              ),
              SizedBox(height: 20.0),
              FormBuilderTextField(
                name: 'Phone Number',
                decoration: InputDecoration(
                  hintText: "",
                  labelText: "Phone Number",
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    borderSide: BorderSide(color: CustomColors.PrimaryColor),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                    FormBuilderValidators.numeric(),
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(8,errorText: "Phone number must be more than or equal to 8"),
                ]),

                onSaved: ((value) => phoneNumber = value) as void Function(String?)?,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                      borderSide: BorderSide(color: CustomColors.PrimaryColor),
                    ),
                    hintText: "Write your question",
                    // labelText: "Write your question",
                    labelStyle: TextStyle(color: Colors.grey[600])),
                maxLines: null,
                maxLength: 100,
                minLines: 5,
                keyboardType: TextInputType.multiline,
                validator: FormBuilderValidators.required(),
                onSaved: ((value) => question = value) as void Function(String?)?,
              ),
              SizedBox(height: 20.0),
              RoundedButton(
                color: CustomColors.PrimaryColor,
                textColor: Colors.white,
                title: 'Send',
                onClick: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    scaffoldKey.currentState!.showSnackBar(SnackBar(
                      backgroundColor: CustomColors.SuccessMessageColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          side: BorderSide(
                              color: CustomColors.SuccessMessageBorderColor)),
                      margin: EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      content: Text(
                        "Success:\n Your message has been sent successfully.",
                        style: TextStyle(
                            color: CustomColors.GreyColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ));
                  } else {
                    scaffoldKey.currentState!.showSnackBar(SnackBar(
                      backgroundColor: CustomColors.ErrorMessageColor,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                          side: BorderSide(
                              color: CustomColors.ErrorMessageBorderColor)),
                      margin: EdgeInsets.symmetric(
                          vertical: 50.0, horizontal: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                      content: Text(
                        "Error:\n A problem has been occurred while submitting your message.",
                        style: TextStyle(
                            color: CustomColors.GreyColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
