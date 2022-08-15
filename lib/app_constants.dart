import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class CustomColors {
  static const PrimaryColor = Color(0xFF8FC743);
  static const PrimaryDarkColor = Color(0xFF0F6F3A);
  static const DarkGrassGreen = Color(0xFF6FA822);
  static const DarkLeavesGreen = Color(0xFF06582B);
  static const LightGreenColor = Color(0xFF4CD964);
  static const LightLeavesGreen = Color(0xFF5EB14E);
  static const PrimaryAssentColor = Color(0xFFEE4598);
  static const DarkPink = Color(0xFFD91575);
  static const GreyColor = Color(0xFF707070);
  static const YellowColor = Color(0xFF4E4E4E);
  static const DarkYellowColor = Color(0xFF0000);
  static const LightGreyColor = Color(0xFFF5F5F5);
  static const GreyBorderColor = Color(0xFFC2C4CA);
  static const GreyDividerColor= Color(0xFFEBEBEB);
  static const GreyCardColor= Color(0xFFFBFBFB);
  static const ErrorEntryFieldColor =  Color(0xFFFF0000);
  static const ErrorMessageColor = Color(0xFFF8D7DA);
  static const ErrorMessageBorderColor = Color(0xFFF5C9CD);
  static const SuccessMessageColor = Color(0xFFD4EDDA);
  static const SuccessMessageBorderColor = Color(0xFFC3E6CB);
}

class ConstMeasures {
  static const double borderWidth = 20.0;
  static const double borderRadius = 15.0;
  static const double borderCircular = 50.0;

  static  String unAuthenticatedMessage = 'not-authed-msg';
  // static const int patient_id = 3;
  // static const String access_token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImp0aSI6Im15aG9zdEBob3N0LmNvbSJ9.eyJpc3MiOiJteWhvc3RAaG9zdC5jb20iLCJhdWQiOiJteWhvc3RAaG9zdC5jb20iLCJqdGkiOiJteWhvc3RAaG9zdC5jb20iLCJpYXQiOjE2MTM5OTA3MzcsImV4cCI6MTY0NDc0OTEzNywiYWNjb3VudF9pZCI6MTN9.XxbHVMAUxOa7_L3ZfhWshkBCjprcUyCyfcKKHT-KKbw";
}

class ConstAPIUrls {
  // static const String baseURL = 'http://flexsolutions.technology/food2fit/web/api/';
  static const String baseURL = 'http://192.168.1.105/food2fit/web/api/';
  // static const String baseURL = 'http://192.168.0.145/food2fit/web/api/';
  static const String baseURLFiles = 'http://flexsolutions.technology/food2fit/web/';
  static const String logIn = 'login';
  static const String getGeneralAdvices = 'get-general-advices';
  static const String getCarouselGeneralAdvices = 'get-carousel-general-advices';
  static const String requestAnAppointment = 'request-an-appointment';
  static const String getMedicalTests = 'get-medical-tests?patient_id=';
  static const String getMedicalTestDetails = 'get-medical-test-details?medical_test_id=';
  static const String getPatientVisits = 'get-patient-visits?patient_id=';
  static const String getPatientVisitDetails = 'get-patient-visit-details?visit_id=';
  static const String getDietPrograms = 'get-diet-programs?patient_id=';
  static const String getDietProgramDetails = 'get-diet-program-details?diet_program_id=';
  static const String getLatestDietProgram = 'get-latest-diet-program?patient_id=';
  static const String getProfileInfo = 'get-profile?patient_id=';
    static const String getBasicProfileInfo = 'get-basic-profile-info?patient_id=';
  static const String getPatientWeights = 'get-patient-weights?patient_id=';
  static const String changePassword = 'change-password';
  static const String uploadMedicalTest = 'upload-medical-test';
  static const String getSystemConfigurations = 'get-system-configurations';
  static const String forgetPassword = 'forget-password';
  static const String getNotifications = 'get-notifications?patient_id=';


}
extension xDouble on double{
  bool canBeInt () {
    return  this.floor() == this;
  }
}