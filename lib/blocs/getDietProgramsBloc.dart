import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetDietProgramsBloc {
  late Food2FitRepositories getDietProgramsRepository;
  StreamController? getDietProgramsController;
  StreamSink<ApiResponse<CommonResponse>> get getDietProgramsResponseSink =>
      getDietProgramsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getDietProgramsResponseStream =>
      getDietProgramsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetDietProgramsBloc() {
    getDietProgramsController = StreamController<ApiResponse<CommonResponse>>();
    getDietProgramsRepository = Food2FitRepositories();
    fetchResponse();
  }

  fetchResponse() async {
    getDietProgramsResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response;
      response = await getDietProgramsRepository.getDietProgramsResponse();
      if (response.status!)
        getDietProgramsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getDietProgramsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      getDietProgramsResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    getDietProgramsController?.close();
  }
}