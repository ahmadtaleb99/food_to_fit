import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/widgets/di.dart';

class IngredientWidget {
  Widget getIngredientWidget(String ingredientText) {
    return Column(
      children: [
        Container(
            alignment: getIT<AppPreferences>().isRtl() ?   Alignment.centerRight :  Alignment.centerLeft ,
            child: AutoSizeText(
              ingredientText,
              maxFontSize: 13,
            )),
        Divider(color: Colors.grey)
      ],
    );
  }
}
