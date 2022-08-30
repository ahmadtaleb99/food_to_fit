import 'dart:developer';

import 'package:easy_localization/easy_localization.dart' as local;
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/resources/app_icons.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/blocs/getSystemConfigurationsBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/models/systemConfigurationsModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:food_to_fit/main.dart';


class AboutFoodToFit extends StatefulWidget {
  @override
  AboutFoodToFitState createState() => AboutFoodToFitState();
}

class AboutFoodToFitState extends State<AboutFoodToFit> {
  Future<void>? _launched;
  GetSystemConfigurationsBloc bloc = GetSystemConfigurationsBloc();
  List<SystemConfigurations>? systemConfigurationList;
    final _appPrefs =  getIT<AppPreferences>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget().appBarWidget(AutoSizeText(
          'About Food To Fit'.tr(),
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          maxFontSize: 16,
        )) as PreferredSizeWidget?,
        body: RefreshIndicator(
          onRefresh: () => bloc.fetchResponse(),
          child: StreamBuilder<ApiResponse<CommonResponse>>(
            stream: bloc.getSystemConfigurationsResponseStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return
                        // Container();
                        Loading();
                    break;
                  case Status.COMPLETED_WITH_TRUE:
                    print('COMPLETED_WITH_TRUE');
                    print(snapshot.data!.data!.data);
                    String weekendDays = "";
                    systemConfigurationList = List.from(snapshot.data!.data!.data);
                    List<String> weekendDaysList =
                        systemConfigurationList!.elementAt(0).value!.split(" ");

                    for (int i = 0; i < weekendDaysList.length; i++) {
                      if (i == weekendDaysList.length - 1) {
                        weekendDays =
                            weekendDays + weekendDaysList[i].toString();
                      } else {
                        weekendDays =
                            weekendDays + weekendDaysList[i].toString() + ", ";
                      }
                    }

                    final String appLanguage = _appPrefs.getAppLanguageOrDefault();
                    String? mobilePhone = systemConfigurationList!.elementAt(7).value;
                    String? phone = systemConfigurationList!.elementAt(6).value;
                    String? facebookPage = systemConfigurationList!.elementAt(11).value;
                    String? igAccount = systemConfigurationList!.elementAt(12).value;
                    String about = systemConfigurationList!.
                    firstWhere((element) => element.configOptions == 'about_$appLanguage}').value ?? ' ';
                    return SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: ConstMeasures.borderWidth),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.width / 4,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage(
                                    'assets/images/about_logo@2x.png'),
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20.0),
                                child: AutoSizeText(
                                  systemConfigurationList!.elementAt(10).value!,
                                  style: TextStyle(
                                      color: CustomColors.YellowColor),
                                  maxFontSize: 13.0,
                                )),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      AppIcons.cell_phone,
                                      size: MediaQuery.of(context).size.width /
                                          14,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _launched =
                                              _makePhoneCall('tel:$mobilePhone');
                                        });
                                      },
                                      child: AutoSizeText(

                                        // "Mobile Number: " +
                                        systemConfigurationList!
                                            .elementAt(7)
                                            .value!,
                                        textDirection: TextDirection.ltr ,
                                        maxFontSize: 13.0,
                                        style: TextStyle(

                                            color: CustomColors.YellowColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      AppIcons.ic_call,
                                      size: MediaQuery.of(context).size.width /
                                          16,
                                      color: CustomColors.PrimaryColor,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _launched =
                                              _makePhoneCall('tel:$phone');
                                        });
                                      },
                                      child: AutoSizeText(
                                        // "Clinic Phone Number: " +
                                        systemConfigurationList!
                                            .elementAt(6)
                                            .value!,
                                        maxFontSize: 13.0,
                                        textDirection: TextDirection.ltr ,
                                        style: TextStyle(

                                            color: CustomColors.YellowColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.lock_clock,
                                      size: MediaQuery.of(context).size.width /
                                          14,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      "Work Hours: ".tr() +
                                          systemConfigurationList!
                                              .elementAt(1)
                                              .value! +
                                          " to ".tr() +
                                          systemConfigurationList!
                                              .elementAt(2)
                                              .value!,
                                      maxFontSize: 13.0,
                                      style: TextStyle(
                                          color: CustomColors.YellowColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      Icons.weekend,
                                      size: MediaQuery.of(context).size.width /
                                          14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      "Weekend Days: ".tr() + weekendDays,
                                      maxFontSize: 13.0,
                                      style: TextStyle(
                                          color: CustomColors.YellowColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Tab(
                                      icon: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          child: Image.asset(
                                              "assets/images/pin@2x.png")),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(15.0),
                                    alignment: Alignment.center,
                                    child: AutoSizeText(
                                      systemConfigurationList!
                                          .elementAt(3)
                                          .value!,
                                      maxFontSize: 13,
                                      style: TextStyle(
                                          color: CustomColors.YellowColor),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Tab(
                                      icon: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          child: Image.asset(
                                              "assets/images/facebook@2x.png")),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.all(15.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          _launchURL(

                                              'https://'+facebookPage.toString());
                                        },
                                        child: AutoSizeText(
                                          systemConfigurationList!
                                              .elementAt(11)
                                              .value!,
                                          maxFontSize: 13,
                                          style: TextStyle(
                                              color: CustomColors.YellowColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 5.0, horizontal: 20.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Tab(
                                      icon: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              14,
                                          child: Image.asset(
                                              "assets/images/instagram@2x.png")),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.all(15.0),
                                      child: GestureDetector(
                                        onTap: () async {
                                          _launchURL(
                                              systemConfigurationList!
                                                  .elementAt(12)
                                                  .value!);
                                        },
                                        child: AutoSizeText(
                                          systemConfigurationList!
                                              .elementAt(12)
                                              .value!,
                                          maxFontSize: 13,
                                          style: TextStyle(
                                              color: CustomColors.YellowColor),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    break;
                  case Status.ERROR:
                    print('error');
                    return CustomErrorWidget(
                      errorMessage: snapshot.data!.message,
                      onRetryPressed: () => bloc.fetchResponse(),
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
        ));
  }
}

_launchURL(String url) async {
  final uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri );
  } else {
    throw 'Could not launch ${uri.toString()}';
  }
}

Future<void> _makePhoneCall(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
  if (snapshot.hasError) {
    return Text('Error: ${snapshot.error}');
  } else {
    return const Text('');
  }
}
