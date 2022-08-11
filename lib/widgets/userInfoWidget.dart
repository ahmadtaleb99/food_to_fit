import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/app_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';

class UserInfoWidget {
  Widget getUserInfoWidget(
      BuildContext context, bool loading, String imageURL, String patientName) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: ConstMeasures.borderWidth),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(ConstMeasures.borderCircular),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(left: 100.0),
                child: AutoSizeText(
                  "Welcome: ".tr()+ patientName,
                  minFontSize: 14,
                  maxFontSize: 16,
                  maxLines: 1,
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            height: 100,
            child: loading
                ? Hero(
                    tag: 'profileImage',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(ConstMeasures.borderCircular),
                        image: DecorationImage(
                            image: NetworkImage(imageURL), fit: BoxFit.fill),
                        boxShadow: [BoxShadow(color: CustomColors.GreyBorderColor, offset: Offset(1, 1), blurRadius: 1.0, spreadRadius: 1.0)],
                      ),
                    ))
                : Card(
                    elevation: 3.0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ConstMeasures.borderCircular),
                    ),
                    child: Container(
                        margin: EdgeInsets.all(20),
                        child: Icon(AppIcons.user,
                            color: CustomColors.GreyColor, size: 40))),
          ),
        ],
      ),
    );
  }
}
