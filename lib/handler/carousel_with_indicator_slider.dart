import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/models/adviceModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/pages/advice_details_page.dart';


class CarouselWithIndicatorDemo extends StatefulWidget {
  final List<Advice>? advices;
  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }

  CarouselWithIndicatorDemo({required this.advices});
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicatorDemo> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        CarouselSlider(
          items: getImageSliders(context),
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.advices!.map((url) {
            int index = widget.advices!.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? Color.fromRGBO(0, 0, 0, 0.4)
                    : CustomColors.PrimaryColor,
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
  List<Widget> getImageSliders(BuildContext context) {
    return widget.advices!
        .map((item) =>
        getImageSliderWidget(item, context))
        .toList();
  }
}


Widget getImageSliderWidget(Advice advice, BuildContext context){
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AdviceDetails(advice: advice, index: 0)));
    },
    child: Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
        ],
        borderRadius: BorderRadius.circular(ConstMeasures.borderRadius),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          child: Stack(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: advice.imageUrl != null
                    ? ConstAPIUrls.baseURLFiles + advice.imageUrl!
                    : '',
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                    Center(child: Loading()),
                errorWidget: (context, url, error) =>
                    Image(
                      image: AssetImage(
                          'assets/images/started_logo@2x.png'),
                      fit: BoxFit.cover,
                    ),
                fit: BoxFit.cover,
                width: 1000.0,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(100, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  child: Center(
                    child: AutoSizeText(
                      advice.title!,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      minFontSize: 14.0,
                    ),
                  ),
                ),
              ),
            ],
          )),
    ),
  );
}
