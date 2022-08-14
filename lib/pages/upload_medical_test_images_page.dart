import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'drawables/rounded_button.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/blocs/uploadMedicalTestBloc.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:christian_picker_image/christian_picker_image.dart';
import 'package:food_to_fit/main.dart';

class UploadMedicalTestImagesPage extends StatefulWidget {
  final String medicalTestRequestID;

  UploadMedicalTestImagesPage(this.medicalTestRequestID);

  @override
  UploadMedicalTestImagesPageState createState() =>
      UploadMedicalTestImagesPageState();
}

class UploadMedicalTestImagesPageState
    extends State<UploadMedicalTestImagesPage> {
  late UploadMedicalTestBloc bloc;
  bool loading = false;
  List<File> files = [];
  bool _btnEnabled = false;

  @override
  void initState() {
    super.initState();
    takeImage(context);
  }

  void takeImage(BuildContext context) async {
    files = await ChristianPickerImage.pickImages(maxImages: 7);
    print("files" + files.toString());
    if (files.length != 0) {
      _btnEnabled = true;
      setState(() {});
    } else {
      _btnEnabled = false;
      Navigator.of(context).pop();
    }
  }

  // Future _pickImage(BuildContext context) async {
  //   showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         takeImage(context);
  //         return Center();
  //       });
  // }

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
            'Upload medical Test Images'.tr(),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            maxFontSize: 16,
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Column(
            children: [
              _btnEnabled
                  ? Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Note: If you click on any image to edit it, you have to reselect other images.'.tr(),
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  : Container(),
              buildGridView(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RoundedButton(
                    color: CustomColors.PrimaryColor,
                    textColor: Colors.white,
                    title: 'Upload'.tr(),
                    onClick: !_btnEnabled
                        ? null
                        : () {
                            if (files.length != 0) {
                              bloc = UploadMedicalTestBloc(
                                  widget.medicalTestRequestID,
                                  files.length,
                                  files);
                              loading = true;
                              setState(() {});
                            } else {
                              print(
                                  'You have to choose one medical test image at least');
                            }
                          },
                  ))
            ],
          ),
          loading
              ? Container(
                  child: StreamBuilder<ApiResponse<CommonResponse>>(
                    stream: bloc.uploadMedicalTestResponseStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        switch (snapshot.data!.status) {
                          case Status.LOADING:
                            return LoaderWidget();
                            break;
                          case Status.COMPLETED_WITH_TRUE:
                            loading = false;
                            print(snapshot.data!.data);
                            print('COMPLETED_WITH_TRUE');
                            if (snapshot.data!.data!.status!) {
                              Future.delayed(Duration.zero, () {
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                        title: ' ',
                                        message: snapshot.data!.data!.message,
                                        backgroundColor:
                                            CustomColors.SuccessMessageColor,
                                        actionTitle: 'Ok'.tr(),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        onCanceled: null,
                                      );
                                    });
                              });
                            }
                            bloc.uploadMedicalTestResponseSink
                                .add(ApiResponse<CommonResponse>());
                            break;
                          case Status.COMPLETED_WITH_FALSE:
                            if (snapshot.data!.data!.message ==
                                "Your account is unauthorized") {
                              logOut(context);
                            }
                            loading = false;
                            print(snapshot.data!.data!.message);
                            print('COMPLETED_WITH_FALSE');
                            Future.delayed(Duration.zero, () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                      title: ' ',
                                      message: snapshot.data!.data!.message,
                                      backgroundColor:
                                          CustomColors.ErrorMessageColor,
                                      actionTitle: 'Ok'.tr(),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      onCanceled: null,
                                    );
                                  });
                            });
                            bloc.uploadMedicalTestResponseSink
                                .add(ApiResponse<CommonResponse>());
                            break;
                          case Status.ERROR:
                            loading = false;
                            Future.delayed(Duration.zero, () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return CustomDialog(
                                        title: '',
                                        message: snapshot.data!.message,
                                        backgroundColor:
                                            CustomColors.ErrorMessageColor,
                                        actionTitle: 'Retry'.tr(),
                                        onPressed: () {
                                          if (files.length != 0) {
                                            bloc = UploadMedicalTestBloc(
                                                widget.medicalTestRequestID,
                                                files.length,
                                                files);
                                            loading = true;
                                            setState(() {});
                                          } else {
                                            print(
                                                'You have to choose one medical test image at least');
                                          }
                                        },
                                        onCanceled: () =>
                                            Navigator.pop(context));
                                  });
                            });
                            bloc.uploadMedicalTestResponseSink
                                .add(ApiResponse<CommonResponse>());
                            break;
                        }
                      }
                      return Container();
                    },
                  ),
                )
              : Container(),
        ]));
  }

  Widget buildGridView() {
    return ScrollConfiguration(
      behavior: RemoveGlowingBehavior(),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        childAspectRatio: 1,
        children: List.generate(files.length, (index) {
          if (files[index] != null) {
            return Container(
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
                ],
                borderRadius: BorderRadius.circular(ConstMeasures.borderRadius),
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    takeImage(context);
                  });
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(ConstMeasures.borderRadius),
                  child: Stack(
                    children: <Widget>[
                      Image.file(
                        files[index],
                        width: 300,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                      files.length > 1
                          ? Positioned(
                              right: 5,
                              top: 5,
                              child: InkWell(
                                child: Icon(
                                  Icons.remove_circle,
                                  size: 20,
                                  color: CustomColors.ErrorEntryFieldColor,
                                ),
                                onTap: () {
                                  files.removeAt(index);
                                  setState(() {
                                    if (files.length == 0) {
                                      _btnEnabled = false;
                                      Navigator.of(context).pop();
                                    }
                                  });
                                },
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class RemoveGlowingBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
