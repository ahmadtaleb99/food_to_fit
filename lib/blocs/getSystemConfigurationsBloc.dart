import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetSystemConfigurationsBloc {
  late Food2FitRepositories getSystemConfigurationsRepository;
  StreamController? getSystemConfigurationsController;
  StreamSink<ApiResponse<CommonResponse>> get getSystemConfigurationsResponseSink =>
      getSystemConfigurationsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getSystemConfigurationsResponseStream =>
      getSystemConfigurationsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetSystemConfigurationsBloc() {
    getSystemConfigurationsController = StreamController<ApiResponse<CommonResponse>>();
    getSystemConfigurationsRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getSystemConfigurationsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getSystemConfigurationsRepository.getSystemConfigurationsResponse();
      if (response.status!)
        getSystemConfigurationsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getSystemConfigurationsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getSystemConfigurationsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getSystemConfigurationsController?.close();
  }
}