import 'dart:async';
import 'package:food_to_fit/networking/api_response.dart';
import 'package:food_to_fit/repository/food2FitRepositories.dart';
import 'package:food_to_fit/models/responseModel.dart';

class RequestAnAppointmentBloc {
  int? patientId;
  String? phone;
  String? meetingType;
  String? guestName;

  late Food2FitRepositories requestAnAppointmentRepository;
  StreamController? requestAnAppointmentController;
  StreamSink<ApiResponse<CommonResponse>> get requestAnAppointmentResponseSink =>
      requestAnAppointmentController!.sink as StreamSink<ApiResponse<CommonResponse>>;
  Stream<ApiResponse<CommonResponse>> get requestAnAppointmentResponseStream =>
      requestAnAppointmentController!.stream as Stream<ApiResponse<CommonResponse>>;

  RequestAnAppointmentBloc({patientId, phone, meetingType, guestName}) {
    requestAnAppointmentController = StreamController<ApiResponse<CommonResponse>>();
    requestAnAppointmentRepository = Food2FitRepositories();
    fetchResponse(patientId: patientId, phone: phone, meetingType: meetingType, guestName: guestName);
  }

  fetchResponse({patientId, phone, meetingType, guestName}) async {
    requestAnAppointmentResponseSink.add(ApiResponse.loading('Fetching response'));
    try {
      CommonResponse response = await requestAnAppointmentRepository.requestAnAppointmentResponse(patientId: patientId, phone: phone, meetingType: meetingType, guestName: guestName);
      print('cyz');
      if (response.status!)
        requestAnAppointmentResponseSink.add(ApiResponse.completed_with_true(response));
      else
        requestAnAppointmentResponseSink.add(ApiResponse.completed_with_false(response));
      print("completed");
    } catch (e) {
      requestAnAppointmentResponseSink.add(ApiResponse.error(e.toString()));
      print("error");
      print(e);
    }
  }
  dispose() {
    requestAnAppointmentController?.close();
  }
}