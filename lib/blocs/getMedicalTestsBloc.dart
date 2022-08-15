import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';



class GetMedicalTestsBloc {
  late Food2FitRepositories getMedicalTestsRepository;
  StreamController? getMedicalTestsController;
  StreamSink<ApiResponse<CommonResponse>> get getMedicalTestsResponseSink =>
      getMedicalTestsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getMedicalTestsResponseStream =>
      getMedicalTestsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetMedicalTestsBloc() {
    getMedicalTestsController = StreamController<ApiResponse<CommonResponse>>();
    getMedicalTestsRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getMedicalTestsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getMedicalTestsRepository.getMedicalTestsResponse();
      if (response.status!)
        getMedicalTestsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getMedicalTestsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getMedicalTestsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getMedicalTestsController?.close();
  }
}