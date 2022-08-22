import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetSupportedLanguagesBloc {
  late Food2FitRepositories getSupportedLanguagesRepository;
  StreamController? getSupportedLanguagesController;
  StreamSink<ApiResponse<CommonResponse>> get getSupportedLanguagesResponseSink =>
      getSupportedLanguagesController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getSupportedLanguagesResponseStream =>
      getSupportedLanguagesController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetSupportedLanguagesBloc() {
    getSupportedLanguagesController = StreamController<ApiResponse<CommonResponse>>();
    getSupportedLanguagesRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getSupportedLanguagesResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getSupportedLanguagesRepository.getSupportedLanguagesResponse();
      if (response.status!)
        getSupportedLanguagesResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getSupportedLanguagesResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getSupportedLanguagesResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getSupportedLanguagesController?.close();
  }
}