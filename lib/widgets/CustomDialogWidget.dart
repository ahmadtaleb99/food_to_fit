import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';

class CustomDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final String? actionTitle;
  final Color? backgroundColor;
  final Function? onPressed;
  final Function? onCanceled;

  const CustomDialog({Key? key, this.title, this.message, this.actionTitle, this.backgroundColor, this.onPressed, this.onCanceled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            const Radius.circular(10.0),
          )),
          // side: BorderSide(color: CustomColors.ErrorMessageBorderColor)),
      title: Text(
        title!,
        style: TextStyle(
            color: CustomColors.GreyColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        message!,
        style: TextStyle(
            color: CustomColors.GreyColor, fontWeight: FontWeight.bold),
      ),
      actions: [
        FlatButton(
          child: Text(actionTitle!),
          onPressed: onPressed as void Function()?,
        ),
        onCanceled != null ? FlatButton(
            onPressed: onCanceled as void Function()?,
            child: Text('Cancel'),
        ) : Container()
      ],
    );
  }
}