import 'dart:async';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:food_to_fit/main.dart';
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
  LogInBloc(username, password) {
    logInController = StreamController<ApiResponse<CommonResponse>>();
    logInRepository = Food2FitRepositories();
    fetchResponse(username, password);
  }
  fetchResponse(String username, String password) async {
    logInResponseSink.add(ApiResponse.loading('Fetching response'));
    String? token;
    try {

      token =    await FirebaseMessaging.instance.getToken();

    }
    catch (e){
      log(e.toString());
    }



        try {


        CommonResponse response = await logInRepository.getLogInResponse(username, password, token);
          if (response.status == true && token != null )
    logInResponseSink.add(ApiResponse.completed_with_true(response));

     else     if (response.status == false){
            logInResponseSink.add(ApiResponse.completed_with_false(response));
          }

    else if  (token == null)
    logInResponseSink.add(ApiResponse.completed_with_internal_error(response,'firebase-error'));


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