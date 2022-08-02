import 'package:flutter/material.dart';
import 'package:food_to_fit/widgets/homeUserInfoCardWidget.dart';
import 'package:food_to_fit/models/homeActionCardModel.dart';
import 'package:food_to_fit/widgets/profileInfoFieldWidget.dart';
import 'package:food_to_fit/widgets/bodyMeasureWidget.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/widgets/userInfoWidget.dart';
import '../app_icons.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:food_to_fit/pages/multi_patient_page.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/blocs/getProfileBloc.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/main.dart';

// bool loading = false;
// String imageURL = " ";
// // "https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80";
// Image image = Image.network(
//   imageURL,
//   fit: BoxFit.contain,
// );


class ProfileInfoPage extends StatefulWidget {
  @override
  ProfileInfoPageState createState() => ProfileInfoPageState();
}

class ProfileInfoPageState extends State<ProfileInfoPage> {
  ProfileInfo? profile;
  List<PatientDiseases>? diseasesList;

  @override
  void initState() {
    super.initState();
    image.image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((ImageInfo info, bool syncCall) => setState(() {
              loading = true;
            })));
  }

  @override
  Widget build(BuildContext context) {
    return userHomeView(context);
  }

  Widget userHomeView(BuildContext context) {
    GetProfileBloc bloc = GetProfileBloc();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarWidget().appBarWidget(AutoSizeText(
        'Profile Info',
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        maxFontSize: 16,
      )) as PreferredSizeWidget?,
      body: RefreshIndicator(
        onRefresh: () => bloc.fetchResponse(),
        child: StreamBuilder<ApiResponse<CommonResponse>>(
          stream: bloc.getProfileResponseStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data!.status) {
                case Status.LOADING:
                  return Center(
                    child: Loading(),
                  );
                  break;
                case Status.COMPLETED_WITH_TRUE:
                  profile = snapshot.data!.data!.data;
                  print('COMPLETED_WITH_TRUE');
                  print(snapshot.data!.data!.data);
                  diseasesList = profile!.patientDiseases;
                  return Center(
                    child: Container(
                      color: Colors.white,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: ConstMeasures.borderWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              userInfoView(context, snapshot.data!.data!.data),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
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
                  if (snapshot.data!.data!.message ==
                      "Your account is unauthorized") {
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

  Widget userInfoView(BuildContext context, ProfileInfo data) {
    return Column(
      children: [
        UserInfoWidget().getUserInfoWidget(context, loading, imageURL,
            profile!.profile!.firstName! + " " + profile!.profile!.lastName!),
        // profile.patientsProfilesCount > 1 ?
        // RoundedButton(
        //     color: CustomColors.PrimaryColor,
        //     textColor: Colors.white,
        //     title: 'Choose patient',
        //     onClick: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => MultiPatientPage()));
        //     })
        // : Container(),
        // SizedBox(height: 10),
        Container(
          child: Row(
            children: getProfileInfoCards()
                .map((homeAction) =>
                HomeUserInfoCardWidget(borderWidth: ConstMeasures.borderWidth)
                    .homeUserInfoCard(context, homeAction, 3))
                .toList(),
          ),
        ),
        SizedBox(height: 10),
        Container(
          child: Row(
            children: getProfileInfoCards2()
                .map((homeAction) =>
                HomeUserInfoCardWidget(borderWidth: ConstMeasures.borderWidth)
                    .homeUserInfoCard(context, homeAction, 4))
                .toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProfileInfoField().profileInfoFieldWidget(
                  AutoSizeText(
                    data.profile!.firstName! + " " + data.profile!.lastName!,
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  Container(),
                  1),
              data.account!.email != null
                  ? ProfileInfoField().profileInfoFieldWidget(
                  AutoSizeText(
                    data.account!.email!,
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  Container(),
                  1)
                  : Container(),
              ProfileInfoField().profileInfoFieldWidget(
                  AutoSizeText(
                    data.profile!.birthDate!,
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  Container(),
                  1),
              ProfileInfoField().profileInfoFieldWidget(
                  AutoSizeText(
                    data.profile!.work!,
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  AutoSizeText(
                    data.profile!.workHours.toString() + " hours",
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  1),
              ProfileInfoField().profileInfoFieldWidget(
                  AutoSizeText(
                    data.account!.phone!,
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  Container(),
                  1),
              ProfileInfoField().profileInfoFieldWidget(
                  AutoSizeText(
                    data.profile!.livingLocation!,
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                  ),
                  Container(),
                  1),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: ProfileInfoField().profileInfoFieldWidget(
                        AutoSizeText(
                          data.profile!.socialStatus!,
                          style: TextStyle(fontSize: 14),
                          maxFontSize: 14,
                        ),
                        Container(),
                        2),
                  ),
                  SizedBox(width: 15.0),
                  Expanded(
                    flex: 1,
                    child: ProfileInfoField().profileInfoFieldWidget(
                        AutoSizeText(
                          data.profile!.gender!,
                          style: TextStyle(fontSize: 14),
                          maxFontSize: 14,
                        ),
                        Container(),
                        2),
                  ),
                ],
              ),
              ProfileInfoField().profileInfoFieldWidget(
                  AutoSizeText(
                    data.profile!.qualifications!,
                    style: TextStyle(fontSize: 14),
                    maxFontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(),
                  1),
            ],
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              'More Information:',
              style: TextStyle(
                  color: CustomColors.PrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              maxFontSize: 16,
            )),
        Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              'Body Measure',
              style: TextStyle(
                  color: CustomColors.PrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              maxFontSize: 16,
            )),
        SizedBox(height: 10.0),
        Column(
          children: List.generate(profile!.nonStaticBodyMeasures!.length, (index) {
            return profile!.nonStaticBodyMeasures!.values.elementAt(index) != null
                ? BodyMeasureWidget().bodyMeasureWidget(
                profile!.nonStaticBodyMeasures!.keys.elementAt(index) + ' : ',
                profile!.nonStaticBodyMeasures!.values
                    .elementAt(index)
                    .toString())
                : Container();
          }),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: AutoSizeText(
              'Diseases',
              style: TextStyle(
                  color: CustomColors.PrimaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
              maxFontSize: 16,
            )),
        SizedBox(height: 15.0),
        diseasesList!.length == 0
            ? Align(
          alignment: Alignment.centerLeft,
          child: AutoSizeText(
            'There are no diseases',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),
            maxFontSize: 14,
          ),
        )
            : Wrap(
          children: List.generate(diseasesList!.length, (index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              width: (MediaQuery.of(context).size.width / 2) -
                  (ConstMeasures.borderWidth * 2),
              child: Container(
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: CustomColors.LightGreyColor,
                  borderRadius:
                  BorderRadius.circular(ConstMeasures.borderCircular),
                ),
                child: AutoSizeText(
                  diseasesList![index].disease!.diseaseName!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.0),
                  maxFontSize: 14,
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  List<HomeActionCardObject> getProfileInfoCards(){
    return [
      HomeActionCardObject(
        backgroundColor: Colors.white,
        iconBackgroundColor: CustomColors.GreyColor,
        icon: AppIcons.group_358,
        title: profile!.lastPatientWeightMeasureDate != null
            ? profile!.lastPatientWeightMeasureDate.toString()
            : '-',
      ),
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.goal,
          title: profile!.staticBodyMeasures!.weightGoal != null
              ? profile!.staticBodyMeasures!.weightGoal.toString() + ' KG'
              : '-'),
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.weight_scale,
          title: profile!.staticBodyMeasures!.wT != null
              ? profile!.staticBodyMeasures!.wT.toString() + ' KG'
              : '-'),
    ];
  }

  List<HomeActionCardObject> getProfileInfoCards2(){
    return [
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.bmi,
          title: profile!.staticBodyMeasures!.bMI != null
              ? profile!.staticBodyMeasures!.bMI.toStringAsFixed(2)
              : '-'),
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.measurement,
          title: profile!.staticBodyMeasures!.hT != null
              ? profile!.staticBodyMeasures!.hT.toString() + ' cm'
              : '-'),
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.trans_fat,
          title: profile!.staticBodyMeasures!.bodyFatMass != null
              ? profile!.staticBodyMeasures!.bodyFatMass.toString()
              : '-'),
      HomeActionCardObject(
          backgroundColor: Colors.white,
          iconBackgroundColor: CustomColors.GreyColor,
          icon: AppIcons.muscle_flex_outline,
          title: profile!.staticBodyMeasures!.bodyMuscleMass != null
              ? profile!.staticBodyMeasures!.bodyMuscleMass.toString()
              : '-'),
    ];
  }
}