import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/medTestModel.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/widgets/timeLineWidget.dart';
import 'package:food_to_fit/pages/med_test_details_page.dart';
import 'package:food_to_fit/blocs/getMedicalTestsBloc.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/widgets/dataNotFoundWidget.dart';
import 'package:food_to_fit/main.dart';
import 'package:shimmer/shimmer.dart';
class MedTestPage extends StatefulWidget {
  @override
  MedTestPageState createState() => MedTestPageState();
}

class MedTestPageState extends State<MedTestPage> {
  final GetMedicalTestsBloc bloc = GetMedicalTestsBloc();
  List<MedicalTestDetails>? medTests;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: checkAuthentication(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null && snapshot.data == true) {
              return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: RefreshIndicator(
                  onRefresh: () => bloc.fetchResponse(),
                  child: StreamBuilder<ApiResponse<CommonResponse>>(
                    stream: bloc.getMedicalTestsResponseStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return Center(
                              child: Loading(),
                            );
                            break;
                          case Status.COMPLETED_WITH_TRUE:
                            medTests =List.from(snapshot.data!.data!.data);
                            print('COMPLETED_WITH_TRUE');
                            print(snapshot.data!.data!.data);
                            return SingleChildScrollView(
                              child: Container(
                                padding:
                                    EdgeInsets.all(ConstMeasures.borderWidth),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // AutoSizeText('Welcome: Sara AlGhamian',
                                    //     maxFontSize: 14),
                                    // SizedBox(height: 10.0),
                                    // RoundedButton(
                                    //     color: CustomColors.PrimaryColor,
                                    //     textColor: Colors.white,
                                    //     title: 'Upload New Medical Test',
                                    //     onClick: () {
                                    //       Navigator.push(
                                    //               context,
                                    //               MaterialPageRoute(
                                    //                   builder: (context) =>
                                    //                       UploadMedicalTestPage()))
                                    //           .then((value) {
                                    //         bloc.fetchResponse();
                                    //         setState(() {
                                    //           // refresh state of Page1
                                    //         });
                                    //         print("refresh done ");
                                    //       });
                                    //     }),
                                    SizedBox(height: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: medTests!
                                          .map((medTest) => TimeLineWidget()
                                                  .getTimeLineWidget(
                                                      context,
                                                      'Status: '.tr() +
                                                          medTest.fillStatus!.tr(),
                                                      medTest.date!,
                                                      medTest == medTests!.last,
                                                      medTest == medTests!.first,
                                                      () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MedTestDetailsPage(
                                                                previousMedicalTest:
                                                                    medTest))).then(
                                                    (value) {
                                                  bloc.fetchResponse();
                                                  setState(() {
                                                    // refresh state of Page1
                                                  });
                                                  print("refresh done ");
                                                });
                                              }))
                                          .toList(),
                                    )
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
                            print('COMPLETED_WITH_FALSE');
                            if (snapshot.data!.data!.message ==
                                "You don't have any submitted medical test yet.") {
                              return DataNotFound(
                                  errorMessage: snapshot.data!.data!.message?.tr());
                            } else {
                              if (snapshot.data!.data!.message ==
                                  "Your account is unauthorized") {
                                logOut(context);
                              }
                            }
                            break;
                        }
                      }
                      return Container();
                    },
                  ),
                ),
              );
            } else {
              return CustomDialog(
                title: ' ',
                backgroundColor: CustomColors.ErrorMessageColor,
                message: ConstMeasures.unAuthenticatedMessage,
                actionTitle: 'Go to login',
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/LogIn', (Route<dynamic> route) => false);
                },
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<bool> checkAuthentication() async {
    return await SharedPreferencesSingleton()
            .getStringValuesSF(SharedPreferencesSingleton.accessToken) !=
        null;
  }
}
