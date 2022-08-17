import 'package:flutter/material.dart';
import 'package:food_to_fit/models/adviceModel.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';


class AdviceDetails extends StatelessWidget {
  final Advice? advice;
  final int? index;

  AdviceDetails({this.advice, this.index});

  @override
  Widget build(BuildContext context) {
    // data = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: AutoSizeText(
          advice!.title!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          maxFontSize: 16,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'adviceImage' + index.toString(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 3 / 4,
                child: CachedNetworkImage(
              imageUrl: advice!.imageUrl != null ? ConstAPIUrls.baseURLFiles +advice!.imageUrl! : 'assets/images/started_logo@2x.png',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    Center( child: Loading()),
                errorWidget: (context, url, error) => Image(image: AssetImage('assets/images/started_logo@2x.png'), fit: BoxFit.cover,),
                fit: BoxFit.cover,
              ),
              ),
            ),
            SizedBox(height: 6.0), // the space between list items
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: ConstMeasures.borderWidth, vertical: 8.0),
              alignment: Alignment.center,
              child: AutoSizeText(
                advice!.title!,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                maxFontSize: 14,
                // textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              alignment: Alignment.centerLeft,
              padding:
                  EdgeInsets.symmetric(horizontal: ConstMeasures.borderWidth),
              child: advice!.body == null?  Container() : Html(data: advice!.body),
              // AutoSizeText(
              //   advice.body,
              //   style: TextStyle(color: Colors.black),
              //   minFontSize: 14,
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
