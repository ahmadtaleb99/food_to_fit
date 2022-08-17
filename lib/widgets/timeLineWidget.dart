import 'package:easy_localization/easy_localization.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/resources/date_manager.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/pages/drawables/rounded_wrap_content_button.dart';
import '../resources/app_constants.dart';
import 'di.dart';

class TimeLineWidget {
  Widget getTimeLineWidget(BuildContext context, String title, String date,
      bool isLast, bool isFirst, Function onClick) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.25,
        isLast: isLast,
        isFirst: isFirst,
        indicatorStyle: const IndicatorStyle(
          width: 15,
          color: CustomColors.PrimaryColor,
        ),
        beforeLineStyle: const LineStyle(
          color: CustomColors.PrimaryColor,
          thickness: 3,
        ),
        afterLineStyle: const LineStyle(
          color: CustomColors.PrimaryColor,
          thickness: 3,
        ),
        startChild: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              DateManager.getFormatedDate(date),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ),
        endChild: Container(
          padding: EdgeInsets.all(5.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(title, style: TextStyle(fontSize: 14)),
            RoundedButton(
                color: CustomColors.PrimaryColor,
                title: 'View'.tr(),
                onClick: onClick,
                verticalPadding: 0.0,
                horizontalPadding: 0.0)
          ]),
        ),
      ),
    );
  }

  Widget getWeightTimeLineWidget(BuildContext context, String title, String date,
      bool isLast, bool isFirst) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0.5,
        isLast: isLast,
        isFirst: isFirst,
        indicatorStyle: const IndicatorStyle(
          width: 15,
          color: CustomColors.PrimaryColor,
        ),
        beforeLineStyle: const LineStyle(
          color: CustomColors.PrimaryColor,
          thickness: 3,
        ),
        afterLineStyle: const LineStyle(
          color: CustomColors.PrimaryColor,
          thickness: 3,
        ),
        startChild: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            alignment: Alignment.centerRight,
            child: Text(
              date,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
          ),
        ),
        endChild: Container(
          padding: EdgeInsets.all(15.0),
          child:
          Text(title, style: TextStyle(fontSize: 15)),
        ),
      ),
    );
  }
}
