import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/weightBodyMeasureModel.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/widgets/timeLineWidget.dart';
import 'package:food_to_fit/blocs/getPatientWeightsBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/dataNotFoundWidget.dart';
import 'package:food_to_fit/main.dart';


class WeightsPage extends StatefulWidget {
  @override
  WeightsPageState createState() => WeightsPageState();
}

class WeightsPageState extends State<WeightsPage> {
  final GetPatientWeightsBloc bloc = GetPatientWeightsBloc();
  List<WeightBodyMeasure>? weights;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget().appBarWidget(AutoSizeText(
        'Weights Details'.tr(),
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        maxFontSize: 16,
      )) as PreferredSizeWidget?,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: RefreshIndicator(
          onRefresh: () => bloc.fetchResponse(),
          child: StreamBuilder<ApiResponse<CommonResponse>>(
            stream: bloc.getPatientWeightsResponseStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return Center(
                      child: Loading(),
                    );
                    break;
                  case Status.COMPLETED_WITH_TRUE:
                    weights = List.from(snapshot.data!.data!.data);
                    print('COMPLETED_WITH_TRUE');
                    print(snapshot.data!.data!.data);
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.all(ConstMeasures.borderWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText('Your Weights History is:'.tr(),
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(height: 10.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: weights!
                                  .map((weight) => weight.measure != null
                                      ? TimeLineWidget()
                                          .getWeightTimeLineWidget(
                                          context,
                                          weight.measure.toString() + ' KG'.tr(),
                                          weight.date!,
                                          weight == weights!.last,
                                          weight == weights!.first,
                                        )
                                      : Container())
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
                    if (snapshot.data!.data!.message ==
                        "You don't have any weight body measure value yet") {
                      return DataNotFound(
                          errorMessage: snapshot.data!.data!.message);
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
      ),
    );
  }
}
