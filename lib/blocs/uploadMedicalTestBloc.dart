import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class UploadMedicalTestBloc {

  late Food2FitRepositories uploadMedicalTestRepository;
  StreamController? uploadMedicalTestController;
  StreamSink<ApiResponse<CommonResponse>> get uploadMedicalTestResponseSink =>
      uploadMedicalTestController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get uploadMedicalTestResponseStream =>
      uploadMedicalTestController!.stream as Stream<ApiResponse<CommonResponse>>;

  UploadMedicalTestBloc(medicalTestRequestID, imagesCount, photos) {
    uploadMedicalTestController = StreamController<ApiResponse<CommonResponse>>();
    uploadMedicalTestRepository = Food2FitRepositories();
    fetchResponse(medicalTestRequestID, imagesCount, photos);
  }

  fetchResponse(medicalTestRequestID, imagesCount, photos) async {
    uploadMedicalTestResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response = await uploadMedicalTestRepository.uploadMedicalTestResponse(medicalTestRequestID, imagesCount, photos);
      if (response.status!)
        uploadMedicalTestResponseSink.add(ApiResponse.completed_with_true(response));
      else
        uploadMedicalTestResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      uploadMedicalTestResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    uploadMedicalTestController?.close();
  }
}