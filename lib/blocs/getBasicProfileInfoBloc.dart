import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetBasicProfileBloc {
  late Food2FitRepositories getBasicProfileRepository;
  StreamController? getBasicProfileController;
  StreamSink<ApiResponse<CommonResponse>> get getBasicProfileResponseSink =>
      getBasicProfileController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getBasicProfileResponseStream =>
      getBasicProfileController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetBasicProfileBloc() {
    getBasicProfileController = StreamController<ApiResponse<CommonResponse>>();
    getBasicProfileRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getBasicProfileResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getBasicProfileRepository.getBasicProfileInfoResponse();
      if (response.status!)
        getBasicProfileResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getBasicProfileResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {

      getBasicProfileResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getBasicProfileController?.close();
  }
}