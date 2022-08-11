import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/models/visitModel.dart';
import 'package:food_to_fit/widgets/visitDetailsTableWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/blocs/getPatientVisitDetails.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/main.dart';

late GetPatientVisitDetailsBloc bloc;
Visit? visit;

class VisitDetailsPage extends StatelessWidget {
  final Visit? previousVisit;
  final String? visitTitle;

  VisitDetailsPage({this.previousVisit, this.visitTitle});

  @override
  Widget build(BuildContext context) {
    bloc = GetPatientVisitDetailsBloc(previousVisit!.id!);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget().appBarWidget(AutoSizeText(
        visitTitle!,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        maxFontSize: 16,
      )) as PreferredSizeWidget?,
      body: RefreshIndicator(
        onRefresh: () => bloc.fetchResponse(previousVisit!.id),
        child: StreamBuilder<ApiResponse<CommonResponse>>(
          stream: bloc.getPatientVisitDetailsResponseStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Center(
                    child: Loading(),
                  );
                  break;
                case Status.COMPLETED_WITH_TRUE:
                  visit = snapshot.data!.data!.data;
                  print('COMPLETED_WITH_TRUE');
                  print(snapshot.data!.data!.data);
                  return SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      // height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(ConstMeasures.borderWidth),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 10.0),
                          //   child: AutoSizeText(
                          //     'Welcome: Sara AlGhamian',
                          //     style: TextStyle(fontWeight: FontWeight.bold),
                          //     maxFontSize: 16,
                          //   ),
                          // ),
                          // SizedBox(height: 10.0),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              child: Text('Visit Details'.tr(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))),
                          SizedBox(height: 10.0),
                          VisitDetailsTableWidget()
                              .getVisitDetailsTable(context, visit, true),
                          SizedBox(height: 25.0),
                          visit!.paymentId != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          child: Text('Payment'.tr(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16.0,
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      SizedBox(height: 10.0),
                                      VisitDetailsTableWidget()
                                          .getVisitDetailsTable(
                                              context, visit, false),
                                    ])
                              : Container(),
                        ],
                      ),
                    ),
                  );
                  break;
                case Status.ERROR:
                  print('error');
                  return Error(
                    errorMessage: snapshot.data!.message,
                    onRetryPressed: () => bloc.fetchResponse(previousVisit!.id),
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
}
