import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/models/notificationModel.dart';
import 'package:food_to_fit/widgets/notificationWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/blocs/getNotificationsBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/widgets/dataNotFoundWidget.dart';
import 'package:food_to_fit/main.dart';

List<NotificationModel>? notificationList;

class NotificationsPage extends StatelessWidget {
  final GetNotificationsBloc bloc = GetNotificationsBloc();

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
            'Notifications'.tr(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            maxFontSize: 16.0,
          ),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: () => bloc.fetchResponse(),
          child: StreamBuilder<ApiResponse<CommonResponse>>(
            stream: bloc.getNotificationsResponseStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return
                      // Container();
                      Loading();
                    break;
                  case Status.COMPLETED_WITH_TRUE:
                    notificationList = List.from(snapshot.data!.data!.data);
                    print('COMPLETED_WITH_TRUE');
                    print(snapshot.data!.data!.data);
                    return SingleChildScrollView(
                      child: Column(
                        children: notificationList!
                            .map((notification) => NotificationWidget().getNotificationWidget(notification))
                            .toList(),
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
                    if(snapshot.data!.data!.message == "You don't have any notification yet"){
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
        ));
  }
}
