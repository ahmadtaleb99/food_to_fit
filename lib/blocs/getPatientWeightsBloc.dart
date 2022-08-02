import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetPatientWeightsBloc {
  late Food2FitRepositories getPatientWeightsRepository;
  StreamController? getPatientWeightsController;
  StreamSink<ApiResponse<CommonResponse>> get getPatientWeightsResponseSink =>
      getPatientWeightsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getPatientWeightsResponseStream =>
      getPatientWeightsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetPatientWeightsBloc() {
    getPatientWeightsController = StreamController<ApiResponse<CommonResponse>>();
    getPatientWeightsRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getPatientWeightsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getPatientWeightsRepository.getPatientWeightsResponse();
      if (response.status!)
        getPatientWeightsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getPatientWeightsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getPatientWeightsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getPatientWeightsController?.close();
  }
}