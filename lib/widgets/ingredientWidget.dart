import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class IngredientWidget {
  Widget getIngredientWidget(String ingredientText) {
    return Column(
      children: [
        Container(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              ingredientText,
              maxFontSize: 13,
            )),
        Divider(color: Colors.grey)
      ],
    );
  }
}
