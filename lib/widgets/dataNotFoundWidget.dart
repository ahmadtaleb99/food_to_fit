import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';

class DataNotFound extends StatelessWidget {
  final String? errorMessage;

  const DataNotFound({Key? key, this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no_data_found.png", height: 300, width: 300,),
              Text(errorMessage!, style: TextStyle(color: CustomColors.ErrorEntryFieldColor, fontSize: 16.0,), textAlign: TextAlign.center,)
            ]),
      ),
    );
  }
}