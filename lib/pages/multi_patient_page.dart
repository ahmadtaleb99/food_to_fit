import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/pages/main_page.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/userInfoWidget.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_patient_button.dart';
import 'package:food_to_fit/pages/log_in.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../AppPreferences.dart';


bool loading = false;
String imageURL =
    "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80";
Image image = Image.network(
  imageURL,
  fit: BoxFit.contain,
);

class MultiPatientPage extends StatefulWidget {

  List<Profile> patients;
  String email;
  @override
  MultiPatientPageState createState() => MultiPatientPageState();

  MultiPatientPage({
    required this.patients,
    required this.email,
  });
}

class MultiPatientPageState extends State<MultiPatientPage> {
  @override
  void initState() {
    super.initState();
    // image.image.resolve(ImageConfiguration()).addListener(
    //     ImageStreamListener((ImageInfo info, bool syncCall) => setState(() {
    //           loading = true;
    //         })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget().appBarWidget(AutoSizeText(
        'Choose patient'.tr(),
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        maxFontSize: 16,
      )) as PreferredSizeWidget?,
      body: Center(
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstMeasures.borderWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  UserInfoWidget()
                      .getUserInfoWidget(context, loading, imageURL, widget.email),
                  SizedBox(height: 20),
                  Column(
                    children: createButtons(context),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  createButtons(BuildContext context) {
    var roundedButtons = <Widget>[];
    widget.patients.forEach((patient) {
      return roundedButtons.add(RoundedButton()
          .roundedButton(context, CustomColors.PrimaryColor, patient.firstName!+' '+patient.lastName!, () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage(isAuthenticated: true)));
        getIT<AppPreferences>().savePatientId(patient.id!.toString());
      }));
    });

    return roundedButtons;
  }
}


