import 'package:easy_localization/easy_localization.dart';
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
        title!.tr(),
        style: TextStyle(
            color: CustomColors.GreyColor, fontWeight: FontWeight.bold),
      ),
      content: Text(
        message!.tr(),
        style: TextStyle(
            color: CustomColors.GreyColor, fontWeight: FontWeight.bold),
      ),
      actions: [
        FlatButton(
          child: Text(actionTitle!.tr()),
          onPressed: onPressed as void Function()?,
        ),
        onCanceled != null ? FlatButton(
            onPressed: onCanceled as void Function()?,
            child: Text('Cancel'.tr()),
        ) : Container()
      ],
    );
  }
}