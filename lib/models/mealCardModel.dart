import 'package:flutter/material.dart';
import 'package:food_to_fit/widgets/ingredientWidget.dart';

class MealCardObject {
  Color? titleBackgroundColor;
  String? title;
  List<String>? ingredientList;

  MealCardObject(
      {this.titleBackgroundColor, this.title, this.ingredientList});
}