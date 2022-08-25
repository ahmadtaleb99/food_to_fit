import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetLanguagesBloc {
  late Food2FitRepositories getLanguagesRepository;
  StreamController? getLanguagesController;
  StreamSink<ApiResponse<CommonResponse>> get getLanguagesResponseSink =>
      getLanguagesController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getLanguagesResponseStream =>
      getLanguagesController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetLanguagesBloc() {
    getLanguagesController = StreamController<ApiResponse<CommonResponse>>();
    getLanguagesRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getLanguagesResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getLanguagesRepository.getLanguagesResponse();
      if (response.status!)
        getLanguagesResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getLanguagesResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getLanguagesResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getLanguagesController?.close();
  }
}


