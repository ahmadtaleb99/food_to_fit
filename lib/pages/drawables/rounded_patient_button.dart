import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class RoundedButton {
  Widget roundedButton(
      BuildContext context, Color color, String title, Function onClick) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: RaisedButton(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(25.0),
            ),
            side: BorderSide(color: color)),
        onPressed: () {
          onClick();
        },
        color: color,
        textColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: AutoSizeText(
            title,
            style: TextStyle(fontSize: 16),
            maxFontSize: 16,
          ),
        ),
      ),
    );
  }
}
