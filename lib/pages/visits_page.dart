import 'package:flutter/material.dart';
import 'package:food_to_fit/models/visitModel.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/widgets/timeLineWidget.dart';
import 'visit_details_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/blocs/getPatientVisitsBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/widgets/dataNotFoundWidget.dart';
import 'package:food_to_fit/main.dart';

class VisitsPage extends StatefulWidget {
  @override
  VisitsPageState createState() => VisitsPageState();
}

class VisitsPageState extends State<VisitsPage> {
  final GetPatientWeightsBloc bloc = GetPatientWeightsBloc();
  List<Visit>? visits;

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
                    stream: bloc.getPatientVisitsResponseStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return Center(
                              child: Loading(),
                            );
                            break;
                          case Status.COMPLETED_WITH_TRUE:
                            visits = snapshot.data!.data!.data;
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
                                    //     style: TextStyle(
                                    //         fontSize: 16.0, fontWeight: FontWeight.bold)),
                                    // SizedBox(height: 10.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: visits!
                                          .map((visit) => TimeLineWidget()
                                                  .getTimeLineWidget(
                                                      context,
                                                      'Visit: ' +
                                                          (visits!.indexOf(
                                                                      visit) +
                                                                  1)
                                                              .toString(),
                                                      visit.dateTime!,
                                                      visit == visits!.last,
                                                      visit == visits!.first,
                                                      () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VisitDetailsPage(
                                                              previousVisit:
                                                                  visit,
                                                              visitTitle: 'Visit: ' +
                                                                  (visits!.indexOf(
                                                                              visit) +
                                                                          1)
                                                                      .toString(),
                                                            )));
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
                            return Error(
                              errorMessage: snapshot.data!.message,
                              onRetryPressed: () => bloc.fetchResponse(),
                            );
                            break;
                          case Status.COMPLETED_WITH_FALSE:
                            print('COMPLETED_WITH_FALSE');
                            if(snapshot.data!.data!.message == "You don't have any visit yet"){
                              return DataNotFound(errorMessage: snapshot.data!.data!.message);
                            } else {
                              if(snapshot.data!.data!.message == "Your account is unauthorized"){
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
                message:
                    ConstMeasures.unAuthenticatedMessage,
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
