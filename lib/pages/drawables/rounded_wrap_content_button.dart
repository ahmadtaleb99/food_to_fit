import 'package:flutter/material.dart';

class RoundedButtonWrapContent extends StatelessWidget {
  final Color? color;
  final String? title;
  final Function? onClick;
  final double? verticalPadding;
  final double? horizontalPadding;

  RoundedButtonWrapContent({this.color, this.title, this.onClick, this.verticalPadding, this.horizontalPadding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: verticalPadding!, horizontal: horizontalPadding!),
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: RaisedButton(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(25.0),
            ),
            side: BorderSide(color: color!)),
        onPressed: () {
          onClick!();
        },
        color: color,
        textColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: verticalPadding!, horizontal: horizontalPadding!),
            child: Text(
                title!,
                style: TextStyle(fontSize: 14)
            )
        ),
      ),
    );
  }
}