import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_diet_program_button.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/models/mealCardModel.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/ingredientWidget.dart';
import 'package:food_to_fit/resources/app_icons.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/models/dayModel.dart';
import 'package:food_to_fit/blocs/getDietProgramDetailsBloc.dart';
import 'package:food_to_fit/main.dart';

import '../AppPreferences.dart';

class DietProgramDetailsPage extends StatefulWidget {
  final String? dietProgramID;
  final String? dietProgramCreatedAt;

  DietProgramDetailsPage({this.dietProgramID, this.dietProgramCreatedAt});

  @override
  DietProgramDetailsPageState createState() =>
      DietProgramDetailsPageState(dietProgramID: dietProgramID, dietProgramCreatedAt: dietProgramCreatedAt);
}

class DietProgramDetailsPageState extends State<DietProgramDetailsPage> {
  String? dietProgramID;
  String? dietProgramCreatedAt;
  late GetDietProgramDetailsBloc bloc;
  List<MealCardObject>? currCardList;
  List<Day>? daysList;
  int selectedIndex = 0;

  DietProgramDetailsPageState({this.dietProgramID, this.dietProgramCreatedAt});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc = GetDietProgramDetailsBloc(dietProgramID!);
  }

  @override
  Widget build(BuildContext context) {
    print('dietProgramID: ' + dietProgramID.toString());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget().appBarWidget(AutoSizeText(
        'Diet Program at: '.tr() + dietProgramCreatedAt!.split(' ').first,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        maxFontSize: 16,
      )) as PreferredSizeWidget?,
      body: Container(
        color: Colors.white,
        child: StreamBuilder<ApiResponse<CommonResponse>>(
          stream: bloc.getDietProgramDetailsResponseStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Loading();
                  break;
                case Status.COMPLETED_WITH_TRUE:
                  daysList = List.from(snapshot.data!.data!.data);
                  print('COMPLETED_WITH_TRUE');
                  print(snapshot.data!.data!.data);
                  return SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      child: Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: daysList!
                                  .map((day) => RoundedButton(
                                      color:
                                          selectedIndex == daysList!.indexOf(day)
                                              ? CustomColors.PrimaryColor
                                              : CustomColors.GreyDividerColor,
                                      title: "Day ".tr() +
                                          (daysList!.indexOf(day) + 1)
                                              .toString(),
                                      onClick: () {
                                        setState(() {
                                          selectedIndex = daysList!.indexOf(day);
                                          // daysList.clear();
                                        });
                                      },
                                      textColor:
                                          selectedIndex == daysList!.indexOf(day)
                                              ? Colors.white
                                              : Colors.black,
                                      verticalPadding: 50.0,
                                      horizontalPadding: 10.0))
                                  .toList(),
                            ),
                          ),
                          Column(
                              children: daysList![selectedIndex].mealsNumber !=
                                      null
                                  ? getMealCardList(daysList![selectedIndex])
                                      .map((item) => Container(
                                            margin: EdgeInsets.only(
                                                top: 20, bottom: 10),
                                            child: Card(
                                              color: CustomColors.GreyCardColor,
                                              elevation: 3.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 0.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          50),
                                                                  bottomRight:
                                                                      Radius.circular(
                                                                          50)),
                                                          color: item
                                                              .titleBackgroundColor),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 5),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              AppIcons.dish,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            SizedBox(width: 5,),
                                                            Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            5.0),
                                                                child:
                                                                    AutoSizeText(
                                                                  item.title!,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                  maxFontSize:
                                                                      14,
                                                                ))
                                                          ]),
                                                    ),
                                                    Container(
                                                      margin:
                                                          EdgeInsets.fromLTRB(
                                                              15.0,
                                                              15.0,
                                                              5.0,
                                                              15.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: item
                                                            .ingredientList!
                                                            .map((ingredientTitle) =>
                                                                IngredientWidget()
                                                                    .getIngredientWidget(
                                                                        ingredientTitle))
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ))
                                      .toList()
                                  : [
                                      Container(
                                        color: Colors.white,
                                        margin: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2 -
                                                200),
                                        child: Text(
                                            'no-diet-for-day'.tr(),
                                            style:
                                                TextStyle(color: Colors.red),
                                        textAlign: TextAlign.center,),
                                      )
                                    ])
                        ],
                      ),
                    ),
                  );
                  break;
                case Status.ERROR:
                  print('error');
                  return CustomErrorWidget(
                    errorMessage: snapshot.data!.message,
                    onRetryPressed: () => bloc.fetchResponse(dietProgramID),
                  );
                  break;
                case Status.COMPLETED_WITH_FALSE:
                  if(snapshot.data!.data!.message == "Your account is unauthorized"){
                    logOut(context);
                  }
                  break;
              }
            }
            return Container();
          },
        ),
      ),
    );
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
          title: day.meals![i].name!.tr(),
          ingredientList: getIT<AppPreferences>().getAppLanguage() == LanguageType.ENGLISH.getValue() ?

          day.meals![i].englishTextualExplanation!.split("\r\n"):
          day.meals![i].arabicTextualExplanation!.split("\r\n")
      ));
    }
    print("currCardList: " + cardList.toString());
    currCardList = cardList;
    return cardList;
  }
}
