import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
class SnackBarWidget {

  SnackBar getSnackBar(String errorMessage){
    return SnackBar(
      backgroundColor: CustomColors.ErrorMessageColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          ),
          side: BorderSide(
              color: CustomColors.ErrorMessageBorderColor)),
      margin: EdgeInsets.symmetric(
          vertical: 50.0, horizontal: 20.0),
      padding:
      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      content: Text(
        errorMessage,
        style: TextStyle(
            color: CustomColors.GreyColor,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}