import 'dart:io';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:food_to_fit/models/imageUploadModel.dart';
import 'package:image_picker/image_picker.dart';
import 'drawables/rounded_button.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/blocs/uploadMedicalTestBloc.dart';
import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/widgets/LoaderWidget.dart';
import 'package:food_to_fit/widgets/CustomDialogWidget.dart';
import 'package:food_to_fit/main.dart';

class UploadMedicalTestPage extends StatefulWidget {
  @override
  UploadMedicalTestPageState createState() => UploadMedicalTestPageState();
}

class UploadMedicalTestPageState extends State<UploadMedicalTestPage> {
  List<Object> images =[];
  late Future<File> imageFile;
  late UploadMedicalTestBloc bloc;
  bool loading = false;
  List<File?> files = [];
  bool _btnEnabled = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
    });
  }

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
            'Upload medical Test',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            maxFontSize: 16,
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Column(
            children: [
              buildGridView(),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: RoundedButton(
                    color: CustomColors.PrimaryColor,
                    textColor: Colors.white,
                    title: 'Upload',
                    onClick: !_btnEnabled
                        ? null
                        : () {
                            if (getImagesFiles().length != 0) {
                              bloc = UploadMedicalTestBloc(1, files.length, files);
                              loading = true;
                              setState(() {});
                            } else {
                              print(
                                  'You have to choose one medical test image at least');
                            }
                          },
                  )
                  // child: _btnEnabled ? RoundedButton(
                  //   color: CustomColors.PrimaryColor,
                  //   textColor: Colors.white,
                  //   title: 'Upload',
                  //   onClick: () {
                  //     if (getImagesFiles().length != 0) {
                  //       bloc = UploadMedicalTestBloc(
                  //           files.length, files);
                  //       loading = true;
                  //       setState(() {});
                  //     } else {
                  //       print('You have to choose one medical test image at least');
                  //     }
                  //   },
                  // ) : RoundedButton(
                  //   color: CustomColors.GreyDividerColor,
                  //   textColor: Colors.black,
                  //   title: 'Upload',
                  //   onClick: () {},
                  // ),
                  )
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
                                    context: context,
                                    builder: (context) {
                                      return CustomDialog(
                                        title: ' ',
                                        message: snapshot.data!.data!.message,
                                        backgroundColor:
                                            CustomColors.SuccessMessageColor,
                                        actionTitle: 'Ok',
                                        onPressed: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        onCanceled: null,
                                      );
                                    });
                              });
                            }
                            bloc.uploadMedicalTestResponseSink.add(ApiResponse<CommonResponse>());
                            break;
                          case Status.COMPLETED_WITH_FALSE:
                            if(snapshot.data!.data!.message == "Your account is unauthorized"){
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
                                      actionTitle: 'Ok',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      onCanceled: null,
                                    );
                                  });
                            });
                            bloc.uploadMedicalTestResponseSink.add(ApiResponse<CommonResponse>());
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
                                        actionTitle: 'Retry',
                                        onPressed: () {
                                          if (getImagesFiles().length != 0) {
                                            bloc = UploadMedicalTestBloc(
                                                1, files.length, files);
                                            loading = true;
                                            setState(() {});
                                          } else {
                                            print(
                                                'You have to choose one medical test image at least');
                                          }
                                        },
                                      onCanceled: () => Navigator.pop(context));
                                  });
                            });
                            bloc.uploadMedicalTestResponseSink.add(ApiResponse<CommonResponse>());
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
        children: List.generate(images.length, (index) {
          if (images[index] is ImageUploadModel) {
            ImageUploadModel uploadModel = images[index] as ImageUploadModel;
            if (uploadModel.imageFile != null) {
              return Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
                  ],
                  borderRadius:
                      BorderRadius.circular(ConstMeasures.borderRadius),
                ),
                child: GestureDetector(
                  onTap: () {
                    onAddImageClick(index);
                  },
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(ConstMeasures.borderRadius),
                    child: Stack(
                      children: <Widget>[
                        Image.file(
                          uploadModel.imageFile!,
                          width: 300,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          right: 5,
                          top: 5,
                          child: InkWell(
                            child: Icon(
                              Icons.remove_circle,
                              size: 20,
                              color: CustomColors.ErrorEntryFieldColor,
                            ),
                            onTap: () {
                              setState(() {
                                images.replaceRange(
                                    index, index + 1, ['Add Image']);
                                if (getImagesFiles().length == 0)
                                  _btnEnabled = false;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey, offset: Offset(1, 1), blurRadius: 2)
                  ],
                  borderRadius:
                      BorderRadius.circular(ConstMeasures.borderRadius),
                ),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(ConstMeasures.borderRadius),
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      onAddImageClick(index);
                    },
                  ),
                ),
              );
            }
          } else {
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
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ConstMeasures.borderRadius),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    onAddImageClick(index);
                  },
                ),
              ),
            );
          }
        }),
      ),
    );
  }

  Future onAddImageClick(int index) async {
    setState(() {

      imageFile = ImagePicker.platform.pickImage(source: ImageSource.gallery).then((value) => value as File);
      getFileImage(index);
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();

    imageFile.then((file) async {
      setState(() {
        ImageUploadModel imageUpload =  ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
        if (imageUpload.imageFile != null) _btnEnabled = true;
      });
    });
  }

  List<File?> getImagesFiles() {
    files.clear();
    for (int i = 0; i < images.length; i++) {
      if (images[i] is ImageUploadModel) {
        ImageUploadModel uploadModel = images[i] as ImageUploadModel;
        if (uploadModel.imageFile != null) files.add(uploadModel.imageFile);
      }
    }
    return files;
  }
}

class RemoveGlowingBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
