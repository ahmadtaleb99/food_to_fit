import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetGeneralAdvicesBloc {
  late Food2FitRepositories getGeneralAdvicesRepository;
  StreamController? getGeneralAdvicesController;
  StreamSink<ApiResponse<CommonResponse>> get getGeneralAdvicesResponseSink =>
      getGeneralAdvicesController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getGeneralAdvicesResponseStream =>
      getGeneralAdvicesController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetGeneralAdvicesBloc() {
    getGeneralAdvicesController = StreamController<ApiResponse<CommonResponse>>();
    getGeneralAdvicesRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getGeneralAdvicesResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getGeneralAdvicesRepository.getGeneralAdvicesResponse();
      if (response.status!)
        getGeneralAdvicesResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getGeneralAdvicesResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getGeneralAdvicesResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getGeneralAdvicesController?.close();
  }
}