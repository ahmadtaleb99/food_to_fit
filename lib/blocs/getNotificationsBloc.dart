import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetNotificationsBloc {
  late Food2FitRepositories getNotificationsRepository;
  StreamController? getNotificationsController;
  StreamSink<ApiResponse<CommonResponse>> get getNotificationsResponseSink =>
      getNotificationsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getNotificationsResponseStream =>
      getNotificationsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetNotificationsBloc() {
    getNotificationsController = StreamController<ApiResponse<CommonResponse>>();
    getNotificationsRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getNotificationsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getNotificationsRepository.getNotificationsResponse();
      if (response.status!)
        getNotificationsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getNotificationsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getNotificationsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getNotificationsController?.close();
  }
}