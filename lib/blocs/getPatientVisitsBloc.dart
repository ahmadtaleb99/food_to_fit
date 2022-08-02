import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetPatientWeightsBloc {
  late Food2FitRepositories getPatientVisitsRepository;
  StreamController? getPatientVisitsController;
  StreamSink<ApiResponse<CommonResponse>> get getPatientVisitsResponseSink =>
      getPatientVisitsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getPatientVisitsResponseStream =>
      getPatientVisitsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetPatientWeightsBloc() {
    getPatientVisitsController = StreamController<ApiResponse<CommonResponse>>();
    getPatientVisitsRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getPatientVisitsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getPatientVisitsRepository.getPatientVisitsResponse();
      if (response.status!)
        getPatientVisitsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getPatientVisitsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getPatientVisitsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getPatientVisitsController?.close();
  }
}