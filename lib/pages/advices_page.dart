import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/AppPreferences.dart';
import 'package:food_to_fit/models/adviceModel.dart';
import 'package:food_to_fit/widgets/adviceCardWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/blocs/getGeneralAdvicesBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';

List<Advice>? adviceList;

class AdvicesPage extends StatelessWidget {
    final GetGeneralAdvicesBloc bloc = GetGeneralAdvicesBloc(getIT<AppPreferences>().getAppLanguageOrDefault());

    @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: AutoSizeText(
            'Advice'.tr(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            maxFontSize: 16.0,
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () => bloc.fetchResponse(getIT<AppPreferences>().getAppLanguageOrDefault()),
          child: StreamBuilder<ApiResponse<CommonResponse>>(
            stream: bloc.getGeneralAdvicesResponseStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return
                        // Container();
                        Loading();
                    break;
                  case Status.COMPLETED_WITH_TRUE:
                    adviceList = List.from(snapshot.data!.data!.data);
                    print('COMPLETED_WITH_TRUE');
                    print(snapshot.data!.data!.data);
                    return SingleChildScrollView(
                      child: Column(
                        children: adviceList!
                            .map((advice) => AdviceCard(
                                advice: advice,
                                index: adviceList!.indexOf(advice)))
                            .toList(),
                      ),
                    );
                    break;
                  case Status.ERROR:
                    print('error');
                    return CustomErrorWidget(
                      errorMessage: snapshot.data!.message,
                      onRetryPressed: () => bloc.fetchResponse(getIT<AppPreferences>().getAppLanguageOrDefault()),
                    );
                    break;
                  case Status.COMPLETED_WITH_FALSE:
                    break;
                }
              }
              return Container();
            },
          ),
        ));
  }
}
