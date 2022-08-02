import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetMedicalTestDetailsBloc {
  late Food2FitRepositories getMedicalTestDetailsRepository;
  StreamController? getMedicalTestDetailsController;
  StreamSink<ApiResponse<CommonResponse>> get getMedicalTestDetailsResponseSink =>
      getMedicalTestDetailsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getMedicalTestDetailsResponseStream =>
      getMedicalTestDetailsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetMedicalTestDetailsBloc(String medicalTestID) {
    getMedicalTestDetailsController = StreamController<ApiResponse<CommonResponse>>();
    getMedicalTestDetailsRepository = Food2FitRepositories();
    fetchResponse(medicalTestID);
  }

  fetchResponse(medicalTestID) async {
    getMedicalTestDetailsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getMedicalTestDetailsRepository.getMedicalTestDetailsResponse(medicalTestID);
      if (response.status!)
        getMedicalTestDetailsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getMedicalTestDetailsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getMedicalTestDetailsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getMedicalTestDetailsController?.close();
  }
}