import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_wrap_content_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:food_to_fit/models/startedPageModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/sharedPreferences.dart';


class StartedPage extends StatefulWidget {
  @override
  StartedPageState createState() => StartedPageState();
}

class StartedPageState extends State<StartedPage> {
  final controller = PageController(
    initialPage: 0,
  );

  int currentPage = 0;
  List<StartedPageObject> startedPagesDataList = [
    StartedPageObject(
        imagePath: "assets/images/started_1@2x.png",
        title:
        "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore",
        buttonTitle: "Next"),
    StartedPageObject(
        imagePath: "assets/images/started_2@2x.png",
        title:
        "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore",
        buttonTitle: "Next"),
    StartedPageObject(
        imagePath: "assets/images/started_3@2x.png",
        title:
        "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore",
        buttonTitle: "Get Started"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: startedPagesDataList
              .map((startedPageData) => getStartedView(context, startedPageData))
              .toList(),
        ),
      ),
    );
  }

  Widget getStartedView(
      BuildContext context, StartedPageObject startedPageObject) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(startedPageObject.imagePath!),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
        padding: EdgeInsets.symmetric(horizontal: ConstMeasures.borderWidth),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height/64),
            AutoSizeText(startedPageObject.title!, maxFontSize: 14.0, textAlign: TextAlign.center),
            SizedBox(height: MediaQuery.of(context).size.height/8),
            Container(
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  dotWidth: 8.0,
                  dotHeight: 8.0,
                  expansionFactor: 2,
                  dotColor: CustomColors.GreyBorderColor,
                  activeDotColor: CustomColors.PrimaryColor,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height/24),
            Container(
              child: RoundedButton(
                  color: CustomColors.PrimaryColor,
                  title: startedPageObject.buttonTitle,
                  onClick: () async {
                    currentPage = currentPage + 1;
                    if (currentPage < 3) {
                      controller.animateToPage(
                        currentPage,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      await SharedPreferencesSingleton().addBoolToSF(SharedPreferencesSingleton.startedPageWasSeen, true);
                      Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                          '/LogIn', (Route<dynamic> route) => false);
                    }
                  }, verticalPadding: 15.0, horizontalPadding: MediaQuery.of(context).size.width/12),
            ),
          ],
        ),
      ),
    );
  }
}
