import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:food_to_fit/models/dietProgramModel.dart';
import 'package:food_to_fit/models/dayModel.dart';
import 'package:food_to_fit/models/mealCardModel.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/resources/app_icons.dart';
import 'package:food_to_fit/widgets/ingredientWidget.dart';
import 'package:food_to_fit/pages/diet_program_details_page.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CarouselCardsSlider extends StatefulWidget {
  final List<Day>? days;
  final DietProgram? latestDietProgram;

  CarouselCardsSlider({required this.days, required this.latestDietProgram});

  @override
  _CarouselCardsSliderState createState() => _CarouselCardsSliderState();
}

class _CarouselCardsSliderState extends State<CarouselCardsSlider> {
  int current = 0;
  List<String>? longestIngredientList;
  List<MealCardObject> cardList = [];

  @override
  Widget build(BuildContext context) {
    print(widget.days![0].meals!.length.toString());
    cardList = getMealCardList(widget.days![0]);
    longestIngredientList = cardList[0].ingredientList;
    if (widget.days!.length != 0) {
      for (int i = 0; i < widget.days!.length; i++) {
        if (widget.days![i].mealsNumber != null) {
          for (int j = 0; j < widget.days![i].meals!.length; j++) {
            if (longestIngredientList!.length <
                    widget.days![i].meals![j].englishTextualExplanation!
                        .split("\r\n")
                        .length &&
                widget.days![i].meals![j].englishTextualExplanation!
                        .split("\r\n")
                        .length <=
                    5) {
              longestIngredientList = widget
                  .days![i].meals![j].englishTextualExplanation!
                  .split("\r\n");
            }
          }
        }
      }
    }
    final double height = 70.0 * (longestIngredientList!.length + 1) + 50;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 19.0),
      child: CarouselSlider(
        items: getCardSliders(),
        options: CarouselOptions(
            height: height,
            autoPlay: false,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {});
            }),
      ),
    );
  }

  List<Widget> getCardSliders() {
    return cardList != null
        ? cardList
            .map((item) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DietProgramDetailsPage(
                                  dietProgramID: widget.latestDietProgram!.id,
                                  dietProgramCreatedAt:
                                      widget.latestDietProgram!.createdAt,
                                )));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20, bottom: 10),
                    child: Card(
                        color: CustomColors.GreyCardColor,
                        elevation: 3.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(50),
                                        bottomRight: Radius.circular(50)),
                                    color: item.titleBackgroundColor),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 5),
                                child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        AppIcons.dish,
                                        color: Colors.white,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 5.0),
                                          child: AutoSizeText(
                                            item.title!,
                                            style:
                                                TextStyle(color: Colors.white),
                                            maxFontSize: 14.0,
                                          ))
                                    ]),
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(
                                          15.0, 15.0, 5.0, 0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: item.ingredientList!
                                            .map((ingredientTitle) =>
                                                IngredientWidget()
                                                    .getIngredientWidget(
                                                        ingredientTitle))
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                               Expanded(
                                flex: 1,
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          cardList.indexOf(item) != 0
                                              ? Container(
                                                  // padding: EdgeInsets.all(10.0),
                                                  child: Icon(
                                                    Icons.arrow_back_ios_sharp,
                                                    color:
                                                        CustomColors.GreyColor,
                                                    size: 20,
                                                  ),
                                                )
                                              : Container(),
                                          cardList.indexOf(item) !=
                                                  cardList.length - 1
                                              ? Container(
                                                  // padding: EdgeInsets.all(10.0),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_sharp,
                                                    color:
                                                        CustomColors.GreyColor,
                                                    size: 20,
                                                  ),
                                                )
                                              : Container()
                                        ]),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                  ),
                ))
            .toList()
        : Container() as List<Widget>;
  }

  List<MealCardObject> getMealCardList(Day day) {
    List<MealCardObject> cardList = [];
    for (int i = 0; i < day.meals!.length; i++) {
      cardList.add(MealCardObject(
          titleBackgroundColor: day.meals![i].name == "Breakfast"
              ? CustomColors.PrimaryColor
              : (day.meals![i].name == "Snack"
                  ? CustomColors.PrimaryAssentColor
                  : CustomColors.DarkLeavesGreen),
          title: day.meals![i].name,
          ingredientList:
              day.meals![i].englishTextualExplanation!.split("\r\n")));
    }
    print("cardList: " + cardList.toString());
    return cardList;
  }
}
