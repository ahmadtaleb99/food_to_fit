import 'dart:async';
import 'package:food_to_fit/models/profileInfoModel.dart';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class UpdateAccountSettingsBloc {
  late Food2FitRepositories updateAccountRepo;
  StreamController? updateAccountController;
  StreamSink<ApiResponse<CommonResponse>> get updateAccountResponseSink =>
      updateAccountController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get updateAccountResponseStream =>
      updateAccountController!.stream as Stream<ApiResponse<CommonResponse>>;
  UpdateAccountSettingsBloc() {
    updateAccountController = StreamController<ApiResponse<CommonResponse>>();
    updateAccountRepo = Food2FitRepositories();
  }


  fetchResponse(Account account) async {
    updateAccountResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response = await updateAccountRepo.updateAccountSettings(account);
      if (response.status!)
        updateAccountResponseSink.add(ApiResponse.completed_with_true(response));
      else
        updateAccountResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      updateAccountResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    updateAccountResponseSink?.close();
  }
}