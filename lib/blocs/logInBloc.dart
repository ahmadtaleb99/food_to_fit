import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class LogInBloc {
  late Food2FitRepositories logInRepository;
  StreamController? logInController;
  StreamSink<ApiResponse<CommonResponse>> get logInResponseSink =>
      logInController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get logInResponseStream =>
      logInController!.stream as Stream<ApiResponse<CommonResponse>>;
  LogInBloc(username, password, firebaseToken) {
    logInController = StreamController<ApiResponse<CommonResponse>>();
    logInRepository = Food2FitRepositories();
    fetchResponse(username, password, firebaseToken);
  }
  fetchResponse(String username, String password, String? firebaseToken) async {
    logInResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response = await logInRepository.getLogInResponse(username, password, firebaseToken);
      if (response.status!)
        logInResponseSink.add(ApiResponse.completed_with_true(response));
      else
        logInResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      logInResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    logInController?.close();
  }
}