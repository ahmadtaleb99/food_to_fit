import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_to_fit/blocs/getPatientsBloc.dart';
import 'package:food_to_fit/main.dart';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/pages/main_page.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/widgets/dataNotFoundWidget.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/userInfoWidget.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/pages/drawables/rounded_patient_button.dart';
import 'package:food_to_fit/pages/log_in.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../AppPreferences.dart';


bool loading = false;
String imageURL =
    "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80";
Image image = Image.network(
  imageURL,
  fit: BoxFit.contain,
);

class SwitchPatientsPage extends StatefulWidget {


  @override
  SwitchPatientsPageState createState() => SwitchPatientsPageState();


}

class SwitchPatientsPageState extends State<SwitchPatientsPage> {
  final GetPatientsBloc bloc = GetPatientsBloc();

  @override
  void initState() {
    super.initState();
    // image.image.resolve(ImageConfiguration()).addListener(
    //     ImageStreamListener((ImageInfo info, bool syncCall) => setState(() {
    //           loading = true;
    //         })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget().appBarWidget(AutoSizeText(
        'Switch Patient'.tr(),
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        maxFontSize: 16,
      )) as PreferredSizeWidget?,
      body: RefreshIndicator(
        onRefresh: () => bloc.fetchResponse(),
        child: StreamBuilder<ApiResponse<CommonResponse>>(
          stream: bloc.getPatientsResponseStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return
                    // Container();
                    Loading();
                  break;
                case Status.COMPLETED_WITH_TRUE:
                var patients = List.from(snapshot.data!.data!.data);
                  print('COMPLETED_WITH_TRUE');
                  print(snapshot.data!.data!.data);
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: Column(
                        children: [
                          AutoSizeText('Choose between patients in your account.'.tr(),minFontSize: 16,maxFontSize: 22,),
                          SizedBox(height: 10,),
                          Column(
                            children: patients.map((patient) => RoundedButton()
                                .roundedButton(context, CustomColors.PrimaryColor, patient.firstName!+' '+patient.lastName!, () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => MainPage(isAuthenticated: true)));
                              getIT<AppPreferences>().savePatientId(patient.id!.toString());
                            })).toList()
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
      )





      // Center(
      //   child: Container(
      //     color: Colors.white,
      //     height: MediaQuery.of(context).size.height,
      //     width: MediaQuery.of(context).size.width,
      //     child: SingleChildScrollView(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(
      //             horizontal: ConstMeasures.borderWidth),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: <Widget>[
      //             UserInfoWidget()
      //                 .getUserInfoWidget(context, loading, imageURL, widget.email),
      //             SizedBox(height: 20),
      //             Column(
      //               children: createButtons(context),
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }


  // createButtons(BuildContext context) {
  //   var roundedButtons = <Widget>[];
  //   widget.patients.forEach((patient) {
  //     return roundedButtons.add(RoundedButton()
  //         .roundedButton(context, CustomColors.PrimaryColor, patient.firstName!+' '+patient.lastName!, () {
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => MainPage(isAuthenticated: true)));
  //       getIT<AppPreferences>().savePatientId(patient.id!.toString());
  //     }));
  //   });
  //
  //   return roundedButtons;
  // }
}


