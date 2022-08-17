import 'package:flutter/material.dart';
import 'package:food_to_fit/resources/app_constants.dart';

class ProfileInfoField {
  Widget profileInfoFieldWidget(
      Widget textWidget, Widget textWidget2, int widgetsNumber) {
    return Container(
        padding: EdgeInsets.all(20.0),
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: CustomColors.LightGreyColor,
          borderRadius: BorderRadius.circular(ConstMeasures.borderCircular),
        ),
        child: widgetsNumber == 2
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [textWidget,Spacer() ,textWidget2],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [textWidget, textWidget2],
              ));
  }
}
