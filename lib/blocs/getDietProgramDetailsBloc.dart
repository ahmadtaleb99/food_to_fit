import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class GetDietProgramDetailsBloc {
  late Food2FitRepositories getDietProgramDetailsRepository;
  StreamController? getDietProgramDetailsController;
  StreamSink<ApiResponse<CommonResponse>> get getDietProgramDetailsResponseSink =>
      getDietProgramDetailsController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get getDietProgramDetailsResponseStream =>
      getDietProgramDetailsController!.stream as Stream<ApiResponse<CommonResponse>>;
  GetDietProgramDetailsBloc(String dietProgramID) {
    getDietProgramDetailsController = StreamController<ApiResponse<CommonResponse>>();
    getDietProgramDetailsRepository = Food2FitRepositories();
    fetchResponse(dietProgramID);
  }

  fetchResponse(dietProgramID) async {
    getDietProgramDetailsResponseSink.add(ApiResponse.loading('Fetching response'));
    // try {
      CommonResponse response;
      response = await getDietProgramDetailsRepository.getDietProgramDetailsResponse(dietProgramID);
      if (response.status!)
        getDietProgramDetailsResponseSink.add(ApiResponse.completed_with_true(response));
      else
        getDietProgramDetailsResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    // } catch (e) {
    //   getDietProgramDetailsResponseSink.add(ApiResponse.error(e.toString()));
    //   print("error");
    //   print(e);
    // }
  }
  dispose() {
    getDietProgramDetailsController?.close();
  }
}