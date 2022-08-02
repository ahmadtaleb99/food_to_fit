import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DisabledRoundedButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final Function? onClick;

  DisabledRoundedButton({this.color, this.title, this.onClick});

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
        onPressed: onClick!(),
        color: color,
        textColor: Colors.white,
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
