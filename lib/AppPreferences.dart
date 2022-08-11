import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String keyLanguage = 'keyLanguage';

class AppPreferences {


  final SharedPreferences _prefs;
  AppPreferences(this._prefs);

  bool isRtl() => getLocale() == AppLanguages.arabicLocale;

  String getAppLanguage() {
    String? language = _prefs.getString(keyLanguage);

    if (language == null || language.isEmpty) {

      return LanguageType.ENGLISH.getValue();
    }

    return language;
  }

  void changeAppLanguage(BuildContext context,String languageType){

      _prefs.setString(keyLanguage, languageType);

    var locale = getLocale();
    context.setLocale(locale);
  }


  Locale getLocale(){
    String? language = getAppLanguage();

    if (language == null || language.isEmpty) {
      return AppLanguages.englishLocale;
    }

    if(language == LanguageType.ARABIC.getValue()){
      return AppLanguages.arabicLocale;
    }

    return AppLanguages.englishLocale;


  }

  void setLocale(){

  }



}
