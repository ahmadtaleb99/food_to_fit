import 'package:flutter/material.dart';
import 'package:food_to_fit/resources/app_constants.dart';

class LoaderWidget extends StatelessWidget {
  const LoaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      child: Stack(children: <Widget>[
        Opacity(
          opacity: 0.5,
          child: const ModalBarrier(dismissible: false, color: Colors.black),
        ),
        Center(
          child: CircularProgressIndicator(
            valueColor:
            AlwaysStoppedAnimation<Color>(CustomColors.PrimaryColor),
          ),
        ),
      ]),
    );
  }
}