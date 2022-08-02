import 'package:flutter/material.dart';
import 'package:food_to_fit/app_icons.dart';
import 'package:food_to_fit/models/homeActionCardModel.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/pages/weights_page.dart';

class HomeUserInfoCardWidget {
  double? borderWidth;

  HomeUserInfoCardWidget({this.borderWidth});

  Widget homeUserInfoCard(
      BuildContext context, HomeActionCardObject actionCardObject, int cardsNumber) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (actionCardObject.icon == AppIcons.group_358){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => WeightsPage()));
          }
        },
        child: Container(
          height: (MediaQuery.of(context).size.width / cardsNumber) - borderWidth!,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: Colors.white,
            elevation: 3.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, //Center Column contents vertically,
              crossAxisAlignment: CrossAxisAlignment.center, //Center Column contents horizontally,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(cardsNumber == 3 ? 10.0 : 5.0),
                  child: Icon(
                    actionCardObject.icon,
                    color: CustomColors.GreyColor,
                    size: cardsNumber == 3 ? MediaQuery.of(context).size.width / 12
                    : MediaQuery.of(context).size.width / 14,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(cardsNumber == 3 ? 5.0 : 2.5),
                  child: AutoSizeText(
                    actionCardObject.title!,
                    minFontSize:  cardsNumber == 3 ? 12.0 : 8.0,
                    maxFontSize:  cardsNumber == 3 ? 14.0 : 10.0,
                    maxLines: 1,
                    style: TextStyle(color: CustomColors.GreyColor),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
