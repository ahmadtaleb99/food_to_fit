import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String keyLanguageKey = 'keyLanguage';
const String accessTokenKey = 'accessToken';
const String patientIdKey = 'patientIdKey';
const String patientsNumberKey = 'patientsNumberKey';
const String keyOnboardingScreenViewed = 'keyOnboardingScreenViewed';

class AppPreferences {


  final SharedPreferences _prefs;
  AppPreferences(this._prefs);

  bool isRtl() => getAppLanguageOrDefault() == LanguageType.ARABIC.getValue();
    Future<void> saveAccessToken(String accessToken) async{
    await _prefs.setString(accessTokenKey, accessToken);
    log('new access token :  : $accessToken');
    }


  Future<void> savePatientId(String id) async{
    await _prefs.setString(patientIdKey, id);
  }

  Future<void> savePatientsNumber(String id) async{
    await _prefs.setString(patientsNumberKey, id);
  }

  String? getPatientsNumber () => _prefs.getString(patientsNumberKey);
  String? getPatientID () => _prefs.getString(patientIdKey);



    bool isAuthenticated() => _prefs.getString(accessTokenKey) != null;
  String getAppLanguageOrDefault() {
    String? language = _prefs.getString(keyLanguageKey);

    if (language == null || language.isEmpty) {

      return LanguageType.ENGLISH.getValue();
    }

    return language;
  }

  String? getAppLanguage() {
    String? language = _prefs.getString(keyLanguageKey);


    return language;
  }


  Future<void> changeAppLanguage(BuildContext context,String languageType) async {

  await     _prefs.setString(keyLanguageKey, languageType);
        
  
  log('setting language: ${_prefs.getString(keyLanguageKey)}');
    var locale = getLocale();
    context.locale = locale;
  }


  Locale getLocale(){
    String? language = getAppLanguageOrDefault();

    if (language == null || language.isEmpty) {
      return AppLanguages.englishLocale;
    }

    if(language == LanguageType.ARABIC.getValue()){
      return AppLanguages.arabicLocale;
    }

    if(language == LanguageType.PORTUGUESE.getValue()){
      return AppLanguages.portugueseLocale;
    }

    return AppLanguages.englishLocale;


  }

  void setLocale(){

  }
  bool isOnboardingScreenViewed() => _prefs.getBool(keyOnboardingScreenViewed) ?? false;

  void setOnboardingScreenViewed() => _prefs.setBool(keyOnboardingScreenViewed, true);


}
