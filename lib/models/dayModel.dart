import 'dart:developer';

import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:food_to_fit/widgets/di.dart';

class Day {
  String? id;
  String? dietProgramId;
  String? mealsNumber;
  List<Meals>? meals;

  Day({this.id, this.dietProgramId, this.mealsNumber, this.meals});

  Day.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dietProgramId = json['diet_program_id'];
    mealsNumber = json['meals_number'];
    if (json['meals'] != null) {
      meals =  [];
      json['meals'].forEach((v) {
        meals!.add( Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['diet_program_id'] = this.dietProgramId;
    data['meals_number'] = this.mealsNumber;
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {



  String? getLocalizedName (){
    var lang =  getIT<AppPreferences>().getAppLanguageOrDefault();
    if(lang == LanguageType.ENGLISH.getValue())
      return this.englishTextualExplanation;

    if(lang == LanguageType.ARABIC.getValue())
      return this.arabicTextualExplanation;

    if(lang == LanguageType.PORTUGUESE.getValue())
      return this.portugueseTextualExplanation;


    return this.englishTextualExplanation;
  }

  String? id;
  String? name;
  String? dayId;
  String? englishTextualExplanation;
  String? arabicTextualExplanation;
  String? portugueseTextualExplanation;

  String? time;

  Meals(
      {this.id,
        this.name,
        this.dayId,
        this.englishTextualExplanation,
        this.portugueseTextualExplanation,
        this.arabicTextualExplanation,
        this.time});

  Meals.fromJson(Map<String, dynamic> json) {
    log('123123123123213123123'+json['portuguese_textual_explanation'].toString() );
    log((json['portuguese_textual_explanation'] == null).toString());
    id = json['id'];
    name = json['name'];
    dayId = json['day_id'];
    englishTextualExplanation = json['english_textual_explanation'];
    arabicTextualExplanation = json['arabic_textual_explanation'];
    portugueseTextualExplanation = json['portuguese_textual_explanation'] != null ?
    json['portuguese_textual_explanation']
        : json['english_textual_explanation'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['day_id'] = this.dayId;
    data['english_textual_explanation'] = this.englishTextualExplanation;
    data['arabic_textual_explanation'] = this.arabicTextualExplanation;
    data['portuguese_textual_explanation'] = this.portugueseTextualExplanation;
    data['time'] = this.time;
    return data;
  }
}