import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class BodyMeasureWidget {
  Widget bodyMeasureWidget(String bodyMeasureLabel, String bodyMeasureValue) {
    return Column(
      children: [
        Row(
          children: [
            AutoSizeText(bodyMeasureLabel),
            AutoSizeText(
              bodyMeasureValue,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              maxFontSize: 14,
            )
          ],
        ),
        Divider(color: Colors.grey)
      ],
    );
  }
}
