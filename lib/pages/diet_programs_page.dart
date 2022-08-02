import 'package:flutter/material.dart';
import 'package:food_to_fit/models/dietProgramModel.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/widgets/timeLineWidget.dart';
import '../app_constants.dart';
import 'diet_program_details_page.dart';
import 'package:food_to_fit/blocs/getDietProgramsBloc.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/sharedPreferences.dart';
import 'package:food_to_fit/widgets/dataNotFoundWidget.dart';
import 'package:food_to_fit/main.dart';

class DietProgramsPage extends StatefulWidget {
  @override
  DietProgramsPageState createState() => DietProgramsPageState();
}

class DietProgramsPageState extends State<DietProgramsPage> {
  final GetDietProgramsBloc bloc = GetDietProgramsBloc();
  List<DietProgram>? dietPrograms;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                    stream: bloc.getDietProgramsResponseStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return Center(
                              child: Loading(),
                            );
                            break;
                          case Status.COMPLETED_WITH_TRUE:
                            dietPrograms = snapshot.data!.data!.data;
                            print('COMPLETED_WITH_TRUE');
                            print(snapshot.data!.data!.data);
                            return SingleChildScrollView(
                              child: Container(
                                padding:
                                    EdgeInsets.all(ConstMeasures.borderWidth),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: dietPrograms!
                                      .map((dietProgram) =>
                                          TimeLineWidget().getTimeLineWidget(
                                              context,
                                              dietProgram.daysNumber == '1'? dietProgram.daysNumber! + " day" :
                                              dietProgram.daysNumber! + " days",
                                              dietProgram.createdAt!,
                                              dietProgram == dietPrograms!.last,
                                              dietProgram == dietPrograms!.first,
                                              () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DietProgramDetailsPage(
                                                          dietProgramID:
                                                              dietProgram.id,
                                                            dietProgramCreatedAt:
                                                            dietProgram.createdAt
                                                        )));
                                          }))
                                      .toList(),
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
                            if(snapshot.data!.data!.message == "You don't have any diet program yet"){
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
