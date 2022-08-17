import 'package:flutter/material.dart';
import 'package:food_to_fit/resources/app_constants.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(CustomColors.PrimaryColor),
      ),
    );
  }
}
