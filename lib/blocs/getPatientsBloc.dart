import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetPatientsBloc {
  late Food2FitRepositories getPatientsRepo;
  StreamController? getPatientsController;
  StreamSink<ApiResponse<CommonResponse>> get getPatientsResponseSink =>
      getPatientsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getPatientsResponseStream =>
      getPatientsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetPatientsBloc() {
    getPatientsController = StreamController<ApiResponse<CommonResponse>>();
    getPatientsRepo = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getPatientsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getPatientsRepo.getPatientsResponse();
      if (response.status!)
        getPatientsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getPatientsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getPatientsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getPatientsController?.close();
  }
}