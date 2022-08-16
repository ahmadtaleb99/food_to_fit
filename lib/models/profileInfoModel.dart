import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/language_manager.dart';
import 'package:food_to_fit/models/dayModel.dart';
import 'package:food_to_fit/models/dietProgramModel.dart';

import '../widgets/di.dart';
class NonStaticBodyMeasure{
  final String nameAr;
  final String nameEn;
  final String namePt;
  final int value;


  String getLocalizedName (){
    var lang =  getIT<AppPreferences>().getAppLanguage();
      switch(lang) {
        case LanguageType.ENGLISH.getValue():
          return nameEn;
      }
  }
  const NonStaticBodyMeasure({
    required this.nameAr,
    required this.nameEn,
    required this.namePt,
    required this.value,
  });
  factory NonStaticBodyMeasure.fromJson(Map<String, dynamic> json) {
    return NonStaticBodyMeasure(nameAr: json['name_ar'],
        nameEn: json['name_en'],
        namePt: json['name_pt'],
        value: json['value']);

  }


  }
class ProfileInfo {
  Profile? profile;
  Account? account;
  int? patientsProfilesCount;
  StaticBodyMeasures? staticBodyMeasures;
  String? lastPatientWeightMeasureDate;
  List<NonStaticBodyMeasure>? nonStaticBodyMeasures;
  List<PatientDiseases>? patientDiseases;
  DietProgram? latestDietProgram;
  List<Day>? dietProgramDays;
  int? patientsCount;


  ProfileInfo(
      {this.profile,
        this.account,
        this.patientsProfilesCount,
        this.staticBodyMeasures,
        this.lastPatientWeightMeasureDate,
        this.nonStaticBodyMeasures,
        this.patientDiseases,
        this.latestDietProgram,
        this.patientsCount,
        this.dietProgramDays});

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    profile =
    json['profile'] != null ?  Profile.fromJson(json['profile']) : null;
    account =
    json['account'] != null ?  Account.fromJson(json['account']) : null;
    patientsProfilesCount = json['patients_profiles_count'];
    staticBodyMeasures = json['static_body_measures'] != null
        ?  StaticBodyMeasures.fromJson(json['static_body_measures'])
        : null;
    lastPatientWeightMeasureDate = json['last_patient_weight_measure_date'];

    nonStaticBodyMeasures = json['non_static_body_measures'] != null
        ? List<NonStaticBodyMeasure>.from(json['non_static_body_measures'])
        .map((dynamic e) => NonStaticBodyMeasure.fromJson(e)).toList()
        : null;
    if (json['patient_diseases'] != null) {
      patientDiseases =  [];
      json['patient_diseases'].forEach((v) {
        patientDiseases!.add( PatientDiseases.fromJson(v));
      });
    }
    latestDietProgram = json['latest_diet_program'] != null
        ?  DietProgram.fromJson(json['latest_diet_program'])
        : null;
    if (json['diet_program_days'] != null) {
      dietProgramDays =  [];
      json['diet_program_days'].forEach((v) {
        dietProgramDays!.add( Day.fromJson(v));
      });
    }
    patientsCount = json['patients_count'] != null ? int.parse(json['patients_count'].toString()) : 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
    if (this.account != null) {
      data['account'] = this.account!.toJson();
    }
    data['patients_profiles_count'] = this.patientsProfilesCount;
    if (this.staticBodyMeasures != null) {
      data['static_body_measures'] = this.staticBodyMeasures!.toJson();
    }
    if (this.nonStaticBodyMeasures != null) {
      data['non_static_body_measures'] = this.nonStaticBodyMeasures;
    }
    data['last_patient_weight_measure_date'] =
        this.lastPatientWeightMeasureDate;
    if (this.patientDiseases != null) {
      data['patient_diseases'] =
          this.patientDiseases!.map((v) => v.toJson()).toList();
    }
    data['last_patient_weight_measure_date'] =
        this.lastPatientWeightMeasureDate;
    if (this.latestDietProgram != null) {
      data['latest_diet_program'] = this.latestDietProgram!.toJson();
    }
    if (this.dietProgramDays != null) {
      data['diet_program_days'] =
          this.dietProgramDays!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}





class Profile {
  int? id;
  String? firstName;
  String? lastName;
  String? birthDate;
  String? gender;
  String? qualifications;
  String? socialStatus;
  dynamic childrenNumber;
  String? work;
  int? workHours;
  String? partnerWork;
  String? getToKnow;
  String? livingLocation;
  String? registrationDate;
  String? status;

  Profile(
      {this.id,
        this.firstName,
        this.lastName,
        this.birthDate,
        this.gender,
        this.qualifications,
        this.socialStatus,
        this.childrenNumber,
        this.work,
        this.workHours,
        this.partnerWork,
        this.getToKnow,
        this.livingLocation,
        this.registrationDate,
        this.status});

  Profile.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id'].toString());
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthDate = json['birth_date'];
    gender = json['gender'];
    qualifications = json['qualifications'];
    socialStatus = json['social_status'];
    childrenNumber = json['children_number'];
    work = json['work'];
    workHours = json['work_hours'] != null ? int.parse(json['work_hours'].toString()) : null ;
    partnerWork = json['partner_work'];
    getToKnow = json['get_to_know'];
    livingLocation = json['living_location'];
    registrationDate = json['registration_date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['birth_date'] = this.birthDate;
    data['gender'] = this.gender;
    data['qualifications'] = this.qualifications;
    data['social_status'] = this.socialStatus;
    data['children_number'] = this.childrenNumber;
    data['work'] = this.work;
    data['work_hours'] = this.workHours;
    data['partner_work'] = this.partnerWork;
    data['get_to_know'] = this.getToKnow;
    data['living_location'] = this.livingLocation;
    data['registration_date'] = this.registrationDate;
    data['status'] = this.status;
    return data;
  }
}

class Account {
  int? id;
  String? email;
  String? password;
  String? phone;
  dynamic resetPasswordToken;
  dynamic deviceToken;
  String? accessToken;

  Account(
      {this.id,
        this.email,
        this.password,
        this.phone,
        this.resetPasswordToken,
        this.deviceToken,
        this.accessToken});

  Account.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    resetPasswordToken = json['reset_password_token'];
    deviceToken = json['device_token'];
    accessToken = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['reset_password_token'] = this.resetPasswordToken;
    data['device_token'] = this.deviceToken;
    data['access_token'] = this.accessToken;
    return data;
  }
}

class StaticBodyMeasures {
  dynamic bMI;
  dynamic bodyMuscleMass;
  dynamic bodyFatMass;
  dynamic wT;
  dynamic hT;
  dynamic weightGoal;

  StaticBodyMeasures(
      {this.bMI, this.bodyMuscleMass, this.bodyFatMass, this.wT, this.hT, this.weightGoal});

  StaticBodyMeasures.fromJson(Map<String, dynamic> json) {
    bMI = json['BMI'];
    bodyMuscleMass = json['Body muscle Mass %'];
    bodyFatMass = json['Body Fat mass %'];
    wT = json['WT'];
    hT = json['HT'];
    weightGoal = json['Weight goal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['BMI'] = this.bMI;
    data['Body muscle Mass %'] = this.bodyMuscleMass;
    data['Body Fat mass %'] = this.bodyFatMass;
    data['WT'] = this.wT;
    data['HT'] = this.hT;
    data['Weight goal'] = this.weightGoal;
    return data;
  }
}

// class NonStaticBodyMeasures {
//   int basicMeasure;
//   int wasteCirc;
//   int thighCirc;
//   int breastCirc;
//   int armCirc;
//   int bFM;
//   int wT5YearsAgo;
//   int rM;
//   int visceralFat;
//
//   NonStaticBodyMeasures(
//       {this.basicMeasure,
//         this.wasteCirc,
//         this.thighCirc,
//         this.breastCirc,
//         this.armCirc,
//         this.bFM,
//         this.wT5YearsAgo,
//         this.rM,
//         this.visceralFat});
//
//   NonStaticBodyMeasures.fromJson(Map<String, dynamic> json) {
//     basicMeasure = json['Basic measure'];
//     wasteCirc = json['Waste circ'];
//     thighCirc = json['Thigh circ'];
//     breastCirc = json['Breast circ'];
//     armCirc = json['Arm circ'];
//     bFM = json['BFM'];
//     wT5YearsAgo = json['WT 5 years ago'];
//     rM = json['RM'];
//     visceralFat = json['Visceral Fat'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data =  Map<String, dynamic>();
//     data['Basic measure'] = this.basicMeasure;
//     data['Waste circ'] = this.wasteCirc;
//     data['Thigh circ'] = this.thighCirc;
//     data['Breast circ'] = this.breastCirc;
//     data['Arm circ'] = this.armCirc;
//     data['BFM'] = this.bFM;
//     data['WT 5 years ago'] = this.wT5YearsAgo;
//     data['RM'] = this.rM;
//     data['Visceral Fat'] = this.visceralFat;
//     return data;
//   }
// }

class PatientDiseases {
  String? id;
  String? patientId;
  String? diseaseId;
  String? optionId;
  String? value;
  Disease? disease;
  Option? option;

  PatientDiseases(
      {this.id,
        this.patientId,
        this.diseaseId,
        this.optionId,
        this.value,
        this.disease,
        this.option});

  PatientDiseases.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    patientId = json['patient_id'];
    diseaseId = json['disease_id'];
    optionId = json['option_id'];
    value = json['value'];
    disease =
    json['disease'] != null ?  Disease.fromJson(json['disease']) : null;
    option =
    json['option'] != null ?  Option.fromJson(json['option']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['patient_id'] = this.patientId;
    data['disease_id'] = this.diseaseId;
    data['option_id'] = this.optionId;
    data['value'] = this.value;
    if (this.disease != null) {
      data['disease'] = this.disease!.toJson();
    }
    if (this.option != null) {
      data['option'] = this.option!.toJson();
    }
    return data;
  }
}

class Disease {
  String? id;
  String? diseaseName;
  String? type;

  Disease({this.id, this.diseaseName, this.type});

  Disease.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diseaseName = json['disease_name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['disease_name'] = this.diseaseName;
    data['type'] = this.type;
    return data;
  }
}

class Option {
  String? id;
  String? diseaseId;
  String? diseaseOption;
  String? status;

  Option({this.id, this.diseaseId, this.diseaseOption, this.status});

  Option.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diseaseId = json['disease_id'];
    diseaseOption = json['disease_option'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['disease_id'] = this.diseaseId;
    data['disease_option'] = this.diseaseOption;
    data['status'] = this.status;
    return data;
  }
}