import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/profileActionWidgetModel.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/pages/profile_info_page.dart';
import 'package:food_to_fit/pages/change_password_page.dart';
import 'package:food_to_fit/pages/settings_page.dart';
import 'package:food_to_fit/pages/notifications_page.dart';
import 'package:auto_size_text/auto_size_text.dart';


class ProfileActionWidget extends StatelessWidget {

  final void Function()? onTap;
final IconData icon;
final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(ConstMeasures.borderCircular),
            ),
            border: Border.all(
                color: CustomColors.GreyBorderColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                // margin: EdgeInsets.all(10.0),
                child: Icon(
                   icon,
                    color: CustomColors.PrimaryColor),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  title.tr(),
                  style: TextStyle(fontSize: 13.0),
                  maxFontSize: 13,
                ),
              ),
            ),
            SizedBox(height: 6.0), // the space between list items
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: CustomColors.GreyBorderColor,
                    size: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  const ProfileActionWidget({
    required this.onTap,
    required this.icon,
    required this.title,
  });
}


