import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/models/notificationModel.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/resources/date_manager.dart';

class NotificationWidget {
  Widget getNotificationWidget(NotificationModel notification) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: AutoSizeText(  
              notification.title.toString(),
              maxFontSize: 18,
              minFontSize: 16,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            )),
        Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: AutoSizeText(
              notification.content.toString(),
              maxFontSize: 16,
              minFontSize: 14,
              style: TextStyle(color: Colors.black),
            )),
        Container(
          margin: EdgeInsets.only(top: 15),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row (children: [
            Icon(
              Icons.access_time_outlined,
              color: Colors.grey,
              size: 20,
            ),
            Container(
                padding: EdgeInsets.all(5.0),
                child: AutoSizeText(
                DateManager.getFormattedDateRtl(  notification.date !),
                  maxFontSize: 12,
                  minFontSize: 10,
                  style: TextStyle(color: CustomColors.GreyColor),
                )),
          ]),
        ),
        Divider(color: Colors.grey)
      ],
    );
  }
}
