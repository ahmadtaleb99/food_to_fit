import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:food_to_fit/pages/drawables/rounded_text_field.dart';
import 'package:food_to_fit/pages/drawables/rounded_wrap_content_button.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/resources/language_manager.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:food_to_fit/models/startedPageModel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/sharedPreferences.dart';

import 'main_page.dart';


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
        buttonTitle: "Next".tr()),
    StartedPageObject(
        imagePath: "assets/images/started_2@2x.png",
        title:
        "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore",
        buttonTitle: "Next".tr()),
    StartedPageObject(
        imagePath: "assets/images/started_3@2x.png",
        title:
        "Lorem dolor sit amet consectetur adipisicing elit, sed do eiusmod tempor incididunt ut ero labore et dolore",
        buttonTitle: "Get Started".tr()),
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
          children: [
            ...startedPagesDataList
                .map((startedPageData) => getStartedView(context, startedPageData))
                .toList()
          ],
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
              child: RoundedButtonWrapContent(
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

                      getIT<AppPreferences>().setOnboardingScreenViewed();
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


class ChooseLanuagePage extends StatelessWidget {
  const ChooseLanuagePage.ChooseLanguagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/log_in_background@2x.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.fromLTRB(
                            50, MediaQuery.of(context).size.height / 5, 50, 20),
                        child: CircleAvatar(
                          radius: 105,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundColor: Colors.white,
                            backgroundImage:
                            AssetImage("assets/images/22@2x.png"),
                          ),
                        )),
                    SizedBox(height: 10),
                    AutoSizeText(
                      'Welcome to Food to Fit App'.tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                      minFontSize: 16.0,
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(25.0),
                            topRight: const Radius.circular(25.0),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          AutoSizeText(
                            'select-lang'.tr(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                            minFontSize: 16.0,
                          ),
                          SizedBox(
                              height:
                              MediaQuery.of(context).size.height / 28),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              RadioListTile(
                                contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                                activeColor: CustomColors.LightLeavesGreen,

                                title:  AutoSizeText(
                                  'English'.tr(),

                                  style: TextStyle(fontSize: 14.0),
                                  maxFontSize: 14,
                                ),
                                groupValue: '_selectedLanguage',
                                onChanged: (String? value) {
                                  // setState(() {
                                  //   _selectedLanguage = value!;
                                  // });
                                }, value: LanguageType.ENGLISH.getValue(),

                              ),
                              RadioListTile(
                                contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                                activeColor: CustomColors.LightLeavesGreen,

                                title:  AutoSizeText(
                                  'Arabic'.tr(),

                                  style: TextStyle(fontSize: 14.0),
                                  maxFontSize: 14,
                                ),
                                groupValue: '_selectedLanguage',
                                onChanged: (String? value) {
                                  // setState(() {
                                  //   _selectedLanguage = value!;
                                  // });
                                }, value: LanguageType.ARABIC.getValue(),

                              ),
                              RadioListTile(
                                contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                                activeColor: CustomColors.LightLeavesGreen,

                                title:  AutoSizeText(
                                  'Portuguese'.tr(),

                                  style: TextStyle(fontSize: 14.0),
                                  maxFontSize: 14,
                                ),
                                groupValue: 'false',
                                onChanged: (String? value) {
                                  // setState(() {
                                  //   _selectedLanguage = value!;
                                  // });
                                }, value: LanguageType.PORTUGUESE.getValue(),

                              ),
                              SizedBox(height: 30),

                              // Container(



                            ],
                          ),
                          SizedBox(height: 20)  ,
                          RoundedButton(
                              color: CustomColors.PrimaryColor,
                              textColor: Colors.white,
                              title: 'Change Password'.tr(),
                              onClick: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainPage(
                                          isAuthenticated: false,
                                        )));
                              }
                          ),
                          SizedBox(height: 15),

                        ],
                      ),
                    )
                  ]),
            ),
          ),
        ),
        // loading
        //     ? Container(
        //   child: StreamBuilder<ApiResponse<CommonResponse>>(
        //     stream: bloc.logInResponseStream,
        //     builder: (context, snapshot) {
        //       if (snapshot.hasData) {
        //         switch (snapshot.data!.status) {
        //           case Status.LOADING:
        //             return LoaderWidget();
        //             break;
        //           case Status.COMPLETED_WITH_TRUE:
        //             loading = false;
        //             print(snapshot.data!.data);
        //             print('COMPLETED_WITH_TRUE');
        //             if (snapshot.data!.data!.status!) {
        //               CommonResponse response = snapshot.data!.data!;
        //               if (response.patientsAccounts!.length == 1 )
        //                 logIn(response, context);
        //               else
        //               if (response.patientsAccounts!.length > 1 )
        //                 _goToMultiPatientPage(response, context);
        //
        //               else
        //                 Future.delayed(Duration.zero, () {
        //                   showDialog(
        //                       context: context,
        //                       builder: (context) {
        //                         return CustomDialog(
        //                           title: 'NO patient'.tr(),
        //                           backgroundColor:
        //                           CustomColors.ErrorMessageColor,
        //                           message: 'There is no patient to login'.tr(),
        //                           actionTitle: 'Ok'.tr(),
        //                           onPressed: () => Navigator.pop(context),
        //                           onCanceled: null,
        //                         );
        //                       });
        //                 });
        //             }
        //             bloc.logInResponseSink.add(ApiResponse<CommonResponse>());
        //             break;
        //           case Status.COMPLETED_WITH_FALSE:
        //             loading = false;
        //             print(snapshot.data!.data!.message);
        //             print('COMPLETED_WITH_FALSE');
        //             Future.delayed(Duration.zero, () {
        //               showDialog(
        //                   context: context,
        //                   builder: (context) {
        //                     return CustomDialog(
        //                       title: 'Wrong:'.tr(),
        //                       backgroundColor:
        //                       CustomColors.ErrorMessageColor,
        //                       message: snapshot.data!.data?.message?.tr(),
        //                       actionTitle: 'Ok'.tr(),
        //                       onPressed: () => Navigator.pop(context),
        //                       onCanceled: null,
        //                     );
        //                   });
        //             });
        //             bloc.logInResponseSink.add(ApiResponse<CommonResponse>());
        //             break;
        //           case Status.ERROR:
        //             loading = false;
        //             Future.delayed(Duration.zero, () {
        //               showDialog(
        //                   context: context,
        //                   builder: (context) {
        //                     return CustomDialog(
        //                         title: '',
        //                         message: snapshot.data!.message,
        //                         backgroundColor:
        //                         CustomColors.ErrorMessageColor,
        //                         actionTitle: 'Retry'.tr(),
        //                         onPressed: () async {
        //                           Navigator.pop(context);
        //                           bloc = LogInBloc(
        //                             usernameController.text,
        //                             passwordController.text,
        //                           );
        //                           loading = true;
        //                           setState(() {});
        //                         },
        //                         onCanceled: () => Navigator.pop(context));
        //                   });
        //             });
        //             bloc.logInResponseSink.add(ApiResponse<CommonResponse>());
        //             break;
        //         }
        //       }
        //       return Container();
        //     },
        //   ),
        // )
        //     : Container(),
      ]),
    );

  }
}
