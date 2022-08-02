import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetPatientVisitDetailsBloc {
  late Food2FitRepositories getPatientVisitDetailsRepository;
  StreamController? getPatientVisitDetailsController;
  StreamSink<ApiResponse<CommonResponse>> get getPatientVisitDetailsResponseSink =>
      getPatientVisitDetailsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getPatientVisitDetailsResponseStream =>
      getPatientVisitDetailsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetPatientVisitDetailsBloc(String visitID) {
    getPatientVisitDetailsController = StreamController<ApiResponse<CommonResponse>>();
    getPatientVisitDetailsRepository = Food2FitRepositories();
    fetchResponse(visitID);
  }

  fetchResponse(visitID) async {
    getPatientVisitDetailsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getPatientVisitDetailsRepository.getPatientVisitDetailsResponse(visitID);
      if (response.status!)
        getPatientVisitDetailsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getPatientVisitDetailsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getPatientVisitDetailsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getPatientVisitDetailsController?.close();
  }
}