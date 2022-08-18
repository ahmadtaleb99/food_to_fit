import 'package:food_to_fit/models/adviceModel.dart';
import 'package:food_to_fit/models/medTestModel.dart';
import 'package:food_to_fit/models/visitModel.dart';
import 'package:food_to_fit/models/dayModel.dart';
import 'package:food_to_fit/models/dietProgramModel.dart';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/models/systemConfigurationsModel.dart';
import 'package:food_to_fit/models/notificationModel.dart';
import 'package:food_to_fit/models/weightBodyMeasureModel.dart';

class CommonResponse {
  String? responseType;
  bool? status;
  String? accessToken;
  List<Profile>? patientsAccounts;
  dynamic data;
  String? message;

  CommonResponse(
      {this.responseType,
      this.status,
      this.accessToken,
      this.patientsAccounts,
      this.data,
      this.message});

  setResponseType(String responseType) {
    this.responseType = responseType;
  }

  fromJson(Map<String, dynamic> json) {
    print('json decoding');
    status = json['status'];
    message = json['message'];
    accessToken = json['access_token'];
    if (json['patients_accounts'] != null) {
      patientsAccounts = [];
      json['patients_accounts'].forEach((v) {
        patientsAccounts!.add( Profile.fromJson(v));
      });
    }
    print('responseType: ' + responseType!);
    if (responseType == "PatientVisits") {
      if (json['data'] != null) {
        data =  [];
        json['data'].forEach((v) {
          data.add( Visit.fromJson(v));
        });
      }
    }


    if (responseType == "SystemConfigurations") {
      if (json['data'] != null) {
        data = [];
        json['data'].forEach((v) {
          data.add(new SystemConfigurations.fromJson(v));
        });
        print('finish');
      }
    }


    if (responseType == "PatientVisitDetails") {
      data = json['data'] != null ?  Visit.fromJson(json['data']) : null;
      print('finish');
    }


    if (responseType == "GeneralAdvices" ||
        responseType == "CarouselGeneralAdvices") {
      if (json['data'] != null) {
        data =  [];
        json['data'].forEach((v) {
          data.add( Advice.fromJson(v));
        });
        print('finish');
      }
    }
    if (responseType == "MedicalTests") {
      if (json['data'] != null) {
        data =  [];
        json['data'].forEach((v) {
          data.add( MedicalTestDetails.fromJson(v));
        });
        print('finish');
      }
    }
    if (responseType == "MedicalTestDetails") {
      data =
          json['data'] != null ?  MedicalTest.fromJson(json['data']) : null;
      print('finish');
    }

    if (responseType == "DietPrograms") {
      if (json['data'] != null) {
        data = [];
        json['data'].forEach((v) {
          data.add( DietProgram.fromJson(v));
        });
        print('finish');
      }
    }
    if (responseType == "DietProgramDetails") {
      if (json['data'] != null) {
        data =  [];
        json['data'].forEach((v) {
          data.add( Day.fromJson(v));
        });
        print('finish');
      }
    }

    if (responseType == "ProfileInfo" || responseType == "BasicProfileInfo") {
      data =
          json['data'] != null ?  ProfileInfo.fromJson(json['data']) : null;
      print('finish');
    }

    if (responseType == "Patients") {
      if (json['data'] != null) {
        data = [];
        json['data'].forEach((v) {
          data.add( Profile.fromJson(v));
        });
        print('finish');
      }
    }

    if (responseType == "Notifications") {
      if (json['data'] != null) {
        data =  [];
        json['data'].forEach((v) {
          data.add( NotificationModel.fromJson(v));
        });
        print('finish');
      }
    }


    if (responseType == "Notifications") {
      if (json['data'] != null) {
        data =  [];
        json['data'].forEach((v) {
          data.add( NotificationModel.fromJson(v));
        });
        print('finish');
      }
    }
    if (responseType == "PatientWeights") {
      if (json['data'] != null) {
          data =  [];
        json['data'].forEach((v) {
          data.add( WeightBodyMeasure.fromJson(v));
        });
        print('finish');
      }
    }

    return CommonResponse(status: status, message: message, data: data, accessToken: accessToken, patientsAccounts: patientsAccounts);
  }
}