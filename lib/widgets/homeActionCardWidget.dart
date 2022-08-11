import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/homeActionCardModel.dart';
import 'package:food_to_fit/pages/request_an_appointment_page.dart';
import 'package:food_to_fit/pages/advices_page.dart';
import 'package:food_to_fit/pages/about_food_to_fit_page.dart';
import 'package:food_to_fit/pages/ask_a_question_page.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomeActionCardWidget {
  double? borderWidth;

  HomeActionCardWidget({this.borderWidth});

  Widget homeActionCard(
      BuildContext context, HomeActionCardObject actionCardObject) {
    return GestureDetector(
      onTap: () {
        if (actionCardObject.title!.compareTo('Request an appointment'.tr()) == 0)
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => RequestAnAppointment()));
        else if (actionCardObject.title!.compareTo('Nutritional Advice'.tr()) == 0)
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AdvicesPage()));
        else if (actionCardObject.title!.compareTo('Ask a question'.tr()) == 0)
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AskAQuestion()));
        else if (actionCardObject.title!.compareTo('About Food To Fit'.tr()) == 0)
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AboutFoodToFit()));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: actionCardObject.backgroundColor,
        margin: EdgeInsets.fromLTRB(borderWidth!, borderWidth!, borderWidth!, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: EdgeInsets.all(10.0),
                child: AutoSizeText(
                  actionCardObject.title!,
                  style: TextStyle(
                      // fontSize: 16.0,
                      color: Colors.white),
                  minFontSize: 16.0,
                  maxLines: 2,
                ),
              ),
            ),
            SizedBox(height: 6.0), // the space between list items
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 3,
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: actionCardObject.iconBackgroundColor,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
                    child: Icon(
                      actionCardObject.icon,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
