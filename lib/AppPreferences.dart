import 'dart:developer';
import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String keyLanguageKey = 'keyLanguage';
const String accessTokenKey = 'accessToken';

class AppPreferences {


  final SharedPreferences _prefs;
  AppPreferences(this._prefs);

  bool isRtl() => getLocale() == AppLanguages.arabicLocale;
    Future<void> saveAccessToken(String accessToken) async{
    await _prefs.setString(accessTokenKey, accessToken);
    log('new access token :  : $accessToken');
    }

    bool isAuthenticated() => _prefs.getString(accessTokenKey) != null;
  String getAppLanguage() {
    String? language = _prefs.getString(keyLanguageKey);

    if (language == null || language.isEmpty) {

      return LanguageType.ENGLISH.getValue();
    }

    return language;
  }

  Future<void> changeAppLanguage(BuildContext context,String languageType) async {

  await     _prefs.setString(keyLanguageKey, languageType);

    var locale = getLocale();
    context.locale = locale;
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
