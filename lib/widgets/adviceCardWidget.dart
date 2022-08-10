import 'package:food_to_fit/pages/advice_details_page.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/adviceModel.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';

class AdviceCard extends StatelessWidget {
  final Advice? advice;
  final int? index;

  AdviceCard({this.advice, this.index});

  @override
  Widget build(BuildContext context) {
    return
      Hero(
      tag: 'adviceImage'+ index.toString(),
      child:
    GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdviceDetails(advice: advice, index: index)));
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(ConstMeasures.borderWidth, ConstMeasures.borderWidth, ConstMeasures.borderWidth, 0),
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1, 1),
                      blurRadius: 2
                    )
                  ],
                  borderRadius: BorderRadius.circular(ConstMeasures.borderRadius),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ConstMeasures.borderRadius),
                  child: CachedNetworkImage(

                    imageUrl: advice!.imageUrl != null ? ConstAPIUrls.baseURLFiles +advice!.imageUrl! : '',
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center( child: Loading()),
                    errorWidget: (context, url, error) => Image(image: AssetImage('assets/images/started_logo@2x.png'), fit: BoxFit.cover,),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 6.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: ConstMeasures.borderWidth, vertical: 8.0),
                alignment: Alignment.center,
                child: AutoSizeText(
                  advice!.title!,
                  style: TextStyle(color: Colors.black),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  maxFontSize: 14,
                ),
              ),
            ],
          ),
        ),
      // ),
    ));
  }
}
