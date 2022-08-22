import 'package:easy_localization/easy_localization.dart' as intl;
import 'package:flutter/material.dart';
import 'package:food_to_fit/pages/images_view_page.dart';
import 'package:food_to_fit/resources/date_manager.dart';
import 'package:food_to_fit/widgets/appBarWidget.dart';
import 'package:food_to_fit/models/medTestModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';
import 'package:food_to_fit/resources/app_constants.dart';
import 'package:food_to_fit/widgets/di.dart';
import 'package:food_to_fit/widgets/medTestDetailsTableWidget.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/blocs/getMedicalTestDetailsBloc.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/widgets/loadingCircularProgress.dart';
import 'package:food_to_fit/widgets/errorWidget.dart';
import 'package:food_to_fit/main.dart';
import 'package:food_to_fit/pages/drawables/rounded_button.dart';
import 'package:food_to_fit/pages/upload_medical_test_images_page.dart';
import 'package:intl/intl.dart';

import '../AppPreferences.dart';

class MedTestDetailsPage extends StatefulWidget {
  final MedicalTestDetails previousMedicalTest;

  MedTestDetailsPage({required this.previousMedicalTest});

  @override
  MedTestDetailsPageState createState() => MedTestDetailsPageState();
}

class MedTestDetailsPageState extends State<MedTestDetailsPage> {
  MedicalTest? medTest;
  late GetMedicalTestDetailsBloc bloc;
  final format = getIT<AppPreferences>().isRtl()
      ? 'HH:MM MM/dd/yyyy  '
      : ' MM/dd/yyyy  HH:MM';
  @override
  Widget build(BuildContext context) {
    bloc = GetMedicalTestDetailsBloc(widget.previousMedicalTest.id!);
    return Scaffold(
      appBar: AppBarWidget().appBarWidget(Text('Medical Test Details'.tr(),
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16))) as PreferredSizeWidget?,
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: RefreshIndicator(
          onRefresh: () => bloc.fetchResponse(widget.previousMedicalTest.id),
          child: StreamBuilder<ApiResponse<CommonResponse>>(
            stream: bloc.getMedicalTestDetailsResponseStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data!.status) {
                  case Status.LOADING:
                    return Loading();
                    break;
                  case Status.COMPLETED_WITH_TRUE:
                    medTest = snapshot.data!.data!.data;
                    print('COMPLETED_WITH_TRUE');
                    // print(snapshot.data.data.data);
                    return SingleChildScrollView(
                      child: Container(
                        color: Colors.white,
                        // height: MediaQuery.of(context).size.height+ConstMeasures.borderWidth,
                        padding: EdgeInsets.all(ConstMeasures.borderWidth),
                        child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: AutoSizeText(
                                    'Status: '.tr() +
                                        medTest!.medicalTestDetails!.fillStatus!
                                            .tr(),
                                    style: TextStyle(color: Colors.black),
                                    maxFontSize: 14,
                                  )),
                              SizedBox(height: 10.0),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: AutoSizeText(
                                    'Time: '.tr() +
                                        DateFormat(format).format(
                                            DateTime.parse(medTest!
                                                .medicalTestDetails!.date!)),
                                    style: TextStyle(color: Colors.black),
                                    maxFontSize: 14,
                                  )),
                              SizedBox(height: 30.0),
                              medTest!.medicalTestDetails!.fillStatus ==
                                      'Filled'
                                  ? Column(
                                      children: List.generate(
                                          medTest!.medicalTestProperties!
                                              .length, (index) {
                                      return MedTestDetailsTableWidget()
                                          .getMedTestDetailsTableWidget(
                                              context,
                                              medTest!.medicalTestProperties!
                                                  .elementAt(index)
                                                  .name!,
                                              medTest!.medicalTestProperties!
                                                  .elementAt(index)
                                                  .properties);
                                    }))
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                          medTest!.medicalTestDetails!
                                                      .fillStatus !=
                                                  'Uploaded'
                                              ? Text(
                                                  'upload-test'.tr(),
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.blueAccent),
                                                )
                                              : Text(
                                                  'Your medical tests and its properties:'
                                                      .tr(),
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Column(
                                              children: List.generate(
                                                  medTest!
                                                      .medicalTestProperties!
                                                      .length, (index) {
                                            int currentType = index;
                                            return Container(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "- " +
                                                      medTest!
                                                          .medicalTestProperties!
                                                          .elementAt(index)
                                                          .name
                                                          .toString() +
                                                      ":",
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: List.generate(
                                                        medTest!
                                                            .medicalTestProperties!
                                                            .elementAt(
                                                                currentType)
                                                            .properties!
                                                            .length, (index) {
                                                      return Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.0),
                                                          child: Text(
                                                            // " ",
                                                            medTest!
                                                                .medicalTestProperties!
                                                                .elementAt(
                                                                    currentType)
                                                                .properties!
                                                                .elementAt(
                                                                    index)
                                                                .name!,
                                                            style: TextStyle(
                                                                fontSize: 16.0),
                                                          ));
                                                    })),
                                                medTest!.medicalTestDetails!
                                                            .fillStatus !=
                                                        "Uploaded"
                                                    ? RoundedButton(
                                                        color: CustomColors
                                                            .PrimaryColor,
                                                        textColor: Colors.white,
                                                        title:
                                                            'Upload New Medical Test'
                                                                .tr(),
                                                        onClick: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      UploadMedicalTestImagesPage(widget
                                                                          .previousMedicalTest
                                                                          .id
                                                                          .toString()))).then(
                                                              (value) {
                                                            bloc.fetchResponse(
                                                                widget
                                                                    .previousMedicalTest
                                                                    .id);
                                                            setState(() {
                                                              // refresh state of Page1
                                                            });
                                                            print(
                                                                "refresh done ");
                                                          });
                                                        },
                                                      )
                                                    : Container()
                                              ],
                                            ));
                                          })),
                                        ]),
                              Center(
                                child: Wrap(
                                  children: List.generate(
                                      medTest!.medicalTestImages!.length,
                                      (index) {
                                    return Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 5.0),
                                        width:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                (ConstMeasures.borderWidth * 2),
                                        height:
                                            (MediaQuery.of(context).size.width /
                                                    2) -
                                                (ConstMeasures.borderWidth * 2),
                                        child: Container(
                                          margin: EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.grey,
                                                  offset: Offset(1, 1),
                                                  blurRadius: 2)
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                ConstMeasures.borderRadius),
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                ConstMeasures.borderRadius),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ImagesViewPage(
                                                                images: medTest!
                                                                    .medicalTestImages,initialIndex: index,)));
                                              },
                                              child: Hero(
                                                tag: medTest!
                                                    .medicalTestImages![
                                                index]
                                                    .id!,
                                                child: PhotoView(
                                                  imageProvider: NetworkImage(
                                                    ConstAPIUrls.baseURLFiles +
                                                        medTest!
                                                            .medicalTestImages![
                                                                index]
                                                            .imagePath!,

                                                  ),
                                                  loadingBuilder: (BuildContext
                                                          context,
                                                      ImageChunkEvent? event) {
                                                    return Center(
                                                        child: Loading());
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ));
                                  }),
                                ),
                              )
                            ]),
                      ),
                    );
                    break;
                  case Status.ERROR:
                    print('error');
                    return CustomErrorWidget(
                      errorMessage: snapshot.data!.message,
                      onRetryPressed: () =>
                          bloc.fetchResponse(widget.previousMedicalTest.id),
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
      ),
    );
  }
}
