import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/resources/app_constants.dart';

class RoundedButton extends StatelessWidget {
  final Color? color;
  final Color? textColor;
  final String? title;
  final Function? onClick;

  RoundedButton({this.color, this.textColor, this.title, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(25.0),
            )),
            // side: BorderSide(color: color)),
        onPressed: onClick as void Function()?,
        color: color,
        textColor: textColor,
        disabledColor: CustomColors.GreyBorderColor,
        disabledTextColor: Colors.white,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: AutoSizeText(
              title!,
              minFontSize: 16,
            )),
      ),
    );
  }
}
