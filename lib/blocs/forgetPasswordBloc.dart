import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class ForgetPasswordBloc {
  late Food2FitRepositories forgetPasswordRepository;
  StreamController? forgetPasswordController;
  StreamSink<ApiResponse<CommonResponse>> get forgetPasswordResponseSink =>
      forgetPasswordController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get forgetPasswordResponseStream =>
      forgetPasswordController!.stream as Stream<ApiResponse<CommonResponse>>;
  ForgetPasswordBloc(String email) {
    forgetPasswordController = StreamController<ApiResponse<CommonResponse>>();
    forgetPasswordRepository = Food2FitRepositories();
    fetchResponse(email);
  }
  fetchResponse(String email) async {
    forgetPasswordResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response = await forgetPasswordRepository.forgetPasswordResponse(email);
      if (response.status!)
        forgetPasswordResponseSink.add(ApiResponse.completed_with_true(response));
      else
        forgetPasswordResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      forgetPasswordResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    forgetPasswordController?.close();
  }
}