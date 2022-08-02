import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetProfileBloc {
  late Food2FitRepositories getProfileRepository;
  StreamController? getProfileController;
  StreamSink<ApiResponse<CommonResponse>> get getProfileResponseSink =>
      getProfileController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getProfileResponseStream =>
      getProfileController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetProfileBloc() {
    getProfileController = StreamController<ApiResponse<CommonResponse>>();
    getProfileRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getProfileResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getProfileRepository.getProfileResponse();
      if (response.status!)
        getProfileResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getProfileResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getProfileResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getProfileController?.close();
  }
}