import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class ChangePasswordBloc {
  late Food2FitRepositories changePasswordRepository;
  StreamController? changePasswordController;
  StreamSink<ApiResponse<CommonResponse>> get changePasswordResponseSink =>
      changePasswordController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get changePasswordResponseStream =>
      changePasswordController!.stream as Stream<ApiResponse<CommonResponse>>;
  ChangePasswordBloc(String newPassword) {
    changePasswordController = StreamController<ApiResponse<CommonResponse>>();
    changePasswordRepository = Food2FitRepositories();
    fetchResponse(newPassword);
  }
  fetchResponse(String newPassword) async {
    changePasswordResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response = await changePasswordRepository.changePasswordResponse(newPassword);
      if (response.status!)
        changePasswordResponseSink.add(ApiResponse.completed_with_true(response));
      else
        changePasswordResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      changePasswordResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    changePasswordController?.close();
  }
}