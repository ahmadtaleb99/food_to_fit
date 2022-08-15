import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final Function? onRetryPressed;

  const CustomErrorWidget({Key? key, this.errorMessage, this.onRetryPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          RaisedButton(
            color: Colors.redAccent,
            child: Text(
              'Retry'.tr(),
              style: TextStyle(color: Colors.white),
            ),
            onPressed: onRetryPressed as void Function()?,
          )
        ],
      ),
    );
  }
}