import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RoundedButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final Color? textColor;
  final Function? onClick;
  final double? verticalPadding;
  final double? horizontalPadding;

  RoundedButton(
      {this.color,
      this.title,
      this.textColor,
      this.onClick,
      this.verticalPadding,
      this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: GestureDetector(
        onTap: onClick as void Function()?,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                const Radius.circular(60.0),
              ),
              border: Border.all(color: color!),
              color: color),
          // onPressed: () {
          //   onClick();
          // },
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: verticalPadding!, horizontal: horizontalPadding!),
            child:
                AutoSizeText(title!, style: TextStyle(color: textColor), maxFontSize: 14),
          ),
        ),
      ),
    );
  }
}
