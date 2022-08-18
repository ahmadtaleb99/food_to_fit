import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/handler/carousel_with_indicator_slider.dart';
import 'package:food_to_fit/resources/app_icons.dart';
import 'package:food_to_fit/models/homeActionCardModel.dart';
import 'package:food_to_fit/models/adviceModel.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/homeActionCardWidget.dart';
import 'package:food_to_fit/blocs/getCarouselGeneralAdvicesBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';


class GuestHomeViewWidget extends StatefulWidget {
  @override
  GuestHomeViewWidgetState createState() => GuestHomeViewWidgetState();
}

class GuestHomeViewWidgetState extends State<GuestHomeViewWidget> {
  GetCarouselGeneralAdvicesBloc bloc = GetCarouselGeneralAdvicesBloc(getIT<AppPreferences>().getAppLanguage());
  List<Advice>? adviceList = [];
  List<HomeActionCardObject> homeActions = [
    HomeActionCardObject(
        backgroundColor: CustomColors.PrimaryColor,
        iconBackgroundColor: CustomColors.DarkGrassGreen,
        icon: AppIcons.appointment,
        title: 'Request an appointment'.tr()),
    HomeActionCardObject(
        backgroundColor: CustomColors.PrimaryAssentColor,
        iconBackgroundColor: CustomColors.DarkPink,
        icon: AppIcons.lightbulb,
        title: 'Nutritional Advice'.tr()),
    // HomeActionCardObject(
    //     backgroundColor: CustomColors.YellowColor,
    //     iconBackgroundColor: CustomColors.DarkYellowColor,
    //     icon: AppIcons.question,
    //     title: 'Ask a question'),
    HomeActionCardObject(
        backgroundColor: CustomColors.PrimaryDarkColor,
        iconBackgroundColor: CustomColors.DarkLeavesGreen,
        icon: AppIcons.pear,
        title: 'About Food To Fit'.tr()),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Text(
          //   'Food To Fit',
          //   style: TextStyle(
          //       color: CustomColors.PrimaryAssentColor,
          //       fontSize: 22.0,
          //       fontWeight: FontWeight.bold),
          // ),
          // Text(
          //   'Nourish Today Flourish Tomorrow',
          //   style: TextStyle(
          //       color: CustomColors.PrimaryColor,
          //       fontSize: 14.0,
          //       fontWeight: FontWeight.bold),
          // ),
          // Container(
          //     margin: EdgeInsets.only(top: 30.0),
          //     width: 170.0,
          //     height: 50.0,
          //     child: Image.asset('assets/images/text_logo.png')),
          SizedBox(height: 10),
          // CarouselWithIndicatorDemo(adviceList),
          Container(
            child: StreamBuilder<ApiResponse<CommonResponse>>(
              stream: bloc.getGeneralAdvicesResponseStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data!.status) {
                    case Status.LOADING:
                      return Loading();
                      break;
                    case Status.COMPLETED_WITH_TRUE:
                      log(snapshot.data!.data!.data.toString());
                      adviceList = List.from(snapshot.data!.data!.data);
                      print('COMPLETED_WITH_TRUE');
                      print(snapshot.data!.data!.data);
                      if (adviceList!.length > 1)
                        return CarouselWithIndicatorDemo(advices: adviceList);
                      else
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                          child: getImageSliderWidget(adviceList!.first, context),
                        );
                      break;
                    case Status.ERROR:
                      print('error');
                      return Container();
                      break;
                    case Status.COMPLETED_WITH_FALSE:
                      Container();
                      break;
                  }
                }
                return Container();
              },
            ),
          ),
          SizedBox(height: 20),
          Column(
            children: homeActions
                .map((homeAction) =>
                    HomeActionCardWidget(borderWidth: ConstMeasures.borderWidth)
                        .homeActionCard(context, homeAction))
                .toList(),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
