import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/pages/started_page.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:food_to_fit/pages/log_in.dart';
import '../app_constants.dart';

class LanguageStartedPage extends StatefulWidget {
  @override
  LanguageStartedPageState createState() => LanguageStartedPageState();
}

class LanguageStartedPageState extends State<LanguageStartedPage>{
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);

    if (seen) {
      Navigator.of(context).pushReplacement(
           MaterialPageRoute(builder: (context) => LogInPage()));
    } else {
      await prefs.setBool('seen', true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: ConstMeasures.borderWidth),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: ConstMeasures.borderWidth),
                      child: Image.asset("assets/images/started_logo@2x.png")),
                  SizedBox(height: 30),
                  AutoSizeText("Choose Your Language", style: TextStyle(fontWeight: FontWeight.bold), minFontSize: 16.0,),
                  SizedBox(height: 20),
                  RoundedButton(
                    color: CustomColors.PrimaryColor,
                    textColor: Colors.white,
                    title: 'English',
                    onClick: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => StartedPage()));
                    },
                  ),
                  SizedBox(height: 5),
                  RoundedButton(
                    color: CustomColors.PrimaryAssentColor,
                    textColor: Colors.white,
                    title: 'العربية',
                    onClick: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => StartedPage()));
                    },
                  ),
                  SizedBox(height: 20),
                ],
              )
            ),
          ),
        ));
  }
}
