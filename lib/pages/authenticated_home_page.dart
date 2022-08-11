import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/handler/carousel_cards_slider.dart';
import 'package:food_to_fit/app_icons.dart';
import 'package:food_to_fit/models/homeActionCardModel.dart';
import 'package:food_to_fit/widgets/homeActionCardWidget.dart';
import 'package:food_to_fit/widgets/homeUserInfoCardWidget.dart';
import 'package:food_to_fit/widgets/userInfoWidget.dart';
import 'package:food_to_fit/pages/profile_info_page.dart';
import 'package:food_to_fit/models/dayModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/blocs/getBasicProfileInfoBloc.dart';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/main.dart';

String imageURL = " ";
// "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80";
// Image image = Image.network(
//   imageURL,
//   fit: BoxFit.contain,
// );

class UserHomeViewWidget extends StatefulWidget {
  @override
  UserHomeViewWidgetState createState() => UserHomeViewWidgetState();
}

class UserHomeViewWidgetState extends State<UserHomeViewWidget> {
  ProfileInfo? profile;
  List<HomeActionCardObject>? homeUserInfoCards;
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

  bool loading = false;
  final GetBasicProfileBloc basicBloc = GetBasicProfileBloc();
  late bool mealsExists;
  List<Day>? daysList = [];

  @override
  void initState() {
    super.initState();
    // image.image
    //     .resolve(ImageConfiguration())
    //     .addListener(ImageStreamListener((ImageInfo info, bool syncCall) {
    //   if (this.mounted)
    //     setState(() {
    //       loading = true;
    //     });
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return userHomeView(context);
  }

  Widget userHomeView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        basicBloc.getBasicProfileResponseSink.add(
            ApiResponse<CommonResponse>());
        return basicBloc.fetchResponse();
      },
      child: StreamBuilder<ApiResponse<CommonResponse>>(
        stream: basicBloc.getBasicProfileResponseStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data!.status) {
              case Status.LOADING:
                return Center(
                  child: Loading(),
                );
                break;
              case Status.COMPLETED_WITH_TRUE:
                profile = snapshot.data!.data!.data;
                print('COMPLETED_WITH_TRUE');
                print(snapshot.data!.data!.data);
                if (snapshot.data!.data!.status!) {
                  daysList = profile!.dietProgramDays;
                  if (daysList!.length != 0) {
                    mealsExists = false;
                    for (int i = 0; i < daysList!.length; i++) {
                      if (daysList![i].meals!.length != 0) {
                        mealsExists = true;
                        break;
                      }
                    }
                  }
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 10),
                        homeUserInfoView(context),
                        Container(
                          // margin: EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: homeActions
                                .map((homeAction) => HomeActionCardWidget(
                                        borderWidth: ConstMeasures.borderWidth)
                                    .homeActionCard(context, homeAction))
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  );
                }
                break;
              case Status.ERROR:
                print('error');
                return Error(
                  errorMessage: snapshot.data!.message,
                  onRetryPressed: () => basicBloc.fetchResponse(),
                );
                break;
              case Status.COMPLETED_WITH_FALSE:
                if (snapshot.data!.data!.message ==
                    "Your account is unauthorized") {
                  logOut(context);
                }
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  Widget homeUserInfoView(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileInfoPage()));
            },
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: ConstMeasures.borderWidth),
                child: UserInfoWidget().getUserInfoWidget(
                    context,
                    loading,
                    imageURL,
                    profile!.profile!.firstName! +
                        " " +
                        profile!.profile!.lastName!))),
        Container(
          width:
              MediaQuery.of(context).size.width - 2 * ConstMeasures.borderWidth,
          child: Row(
            children: getHomeUserInfoCards(profile!)
                .map((homeAction) => HomeUserInfoCardWidget(
                        borderWidth: ConstMeasures.borderWidth)
                    .homeUserInfoCard(context, homeAction, 3))
                .toList(),
          ),
        ),
        daysList!.length != 0 && mealsExists
            ? CarouselCardsSlider(days: daysList, latestDietProgram: profile!.latestDietProgram)
            : Container()
      ],
    );
  }

  List<HomeActionCardObject> getHomeUserInfoCards(ProfileInfo profile) {
    return homeUserInfoCards = [
      HomeActionCardObject(
        backgroundColor: Colors.white,
        iconBackgroundColor: CustomColors.GreyColor,
        icon: AppIcons.group_358,
        title: profile.lastPatientWeightMeasureDate != null
            ? profile.lastPatientWeightMeasureDate.toString()
            : '-',
      ),
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.goal,
          title: profile.staticBodyMeasures!.weightGoal != null
              ? profile.staticBodyMeasures!.weightGoal.toString() + ' KG'.tr()
              : '-'),
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.weight_scale,
          title: profile.staticBodyMeasures!.wT != null
              ? profile.staticBodyMeasures!.wT.toString() + ' KG'.tr()
              : '-'),
    ];
  }
}
