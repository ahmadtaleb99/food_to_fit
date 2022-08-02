import 'dart:async';

import 'package:food_to_fit/models/responseModel.dart';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/networking/api_base_helper.dart';
import 'package:food_to_fit/sharedPreferences.dart';

class Food2FitRepositories {
  ApiBaseHelper helper = ApiBaseHelper();
  CommonResponse commonResponse = CommonResponse();

  
  Future getAccessToken() async {
    return await SharedPreferencesSingleton().getStringValuesSF(SharedPreferencesSingleton.accessToken);
  }

  Future getPatientID() async {
    return await SharedPreferencesSingleton().getStringValuesSF(SharedPreferencesSingleton.patientID);
  }

  Future<CommonResponse> getLogInResponse(
      String username, String password, String? firebaseToken) async {
    final response = await helper.post(ConstAPIUrls.logIn,
        body: {'email': username, 'password': password, 'firebase_token': firebaseToken});
    // if (response.body is Response)
    commonResponse.setResponseType("LogIn");
    return commonResponse.fromJson(response);
    // else
    //   return Response.fromJson(jsonDecode(response.body));
  }

  Future<CommonResponse> getGeneralAdvicesResponse() async {
    final response = await helper.get(ConstAPIUrls.getGeneralAdvices);
    commonResponse.setResponseType("GeneralAdvices");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse>  getCarouselGeneralAdvicesResponse() async {
    final response = await helper.get(ConstAPIUrls.getCarouselGeneralAdvices);
    commonResponse.setResponseType("CarouselGeneralAdvices");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> requestAnAppointmentResponse(
      {String? patientId,
      String? phone,
      String? meetingType,
      String? guestName}) async {
    Map<String, dynamic> body;
    if (await getPatientID() != null) {
      body = {
        'patient_id': await getPatientID(),
        // 'phone': phone,
        'meeting_type': meetingType,
        // 'guest_name': guestName
      };
    } else {
      body = {
        'phone': phone,
        'meeting_type': meetingType,
        'guest_name': guestName
      };
    }

    print("body"+body.toString());

    final response =
        await helper.post(ConstAPIUrls.requestAnAppointment, body: body);
    print(response);
    // if (response.body is Response)
    commonResponse.setResponseType("requestAnAppointment");
    return commonResponse.fromJson(response);
    // else
    //   return Response.fromJson(jsonDecode(response.body));
  }

  Future<CommonResponse> getMedicalTestsResponse() async {
    final response = await helper.get(ConstAPIUrls.getMedicalTests + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print("headers"+await (getAccessToken() as FutureOr<String>));
    print(response);
    commonResponse.setResponseType("MedicalTests");
    return commonResponse.fromJson(response);

  }

  Future<CommonResponse> getMedicalTestDetailsResponse(String medicalTestID) async {
    final response = await helper.get(ConstAPIUrls.getMedicalTestDetails+medicalTestID,
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("MedicalTestDetails");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> getPatientVisitsResponse() async {
    final response = await helper.get(ConstAPIUrls.getPatientVisits + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("PatientVisits");
    return commonResponse.fromJson(response);

  }

  Future<CommonResponse> getPatientWeightsResponse() async {
    final response = await helper.get(ConstAPIUrls.getPatientWeights + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("PatientWeights");
    return commonResponse.fromJson(response);

  }

  Future<CommonResponse> getPatientVisitDetailsResponse(String visitID) async {
    final response = await helper.get(ConstAPIUrls.getPatientVisitDetails+visitID,
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("PatientVisitDetails");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> getDietProgramsResponse() async {
    final response = await helper.get(ConstAPIUrls.getDietPrograms + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("DietPrograms");
    return commonResponse.fromJson(response);

  }

  Future<CommonResponse> getDietProgramDetailsResponse(String dietProgramID) async {
    final response = await helper.get(ConstAPIUrls.getDietProgramDetails+dietProgramID,
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("DietProgramDetails");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> getLatestDietProgramResponse() async {
    final response = await helper.get(ConstAPIUrls.getLatestDietProgram + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("LatestDietProgram");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> getProfileResponse() async {
    final response = await helper.get(ConstAPIUrls.getProfileInfo + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("ProfileInfo");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> getBasicProfileInfoResponse() async {
    final response = await helper.get(ConstAPIUrls.getBasicProfileInfo + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("BasicProfileInfo");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> changePasswordResponse(String newPassword) async {
    final response = await helper.post(ConstAPIUrls.changePassword,
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'},
        body: {'new_password': newPassword});
    print(response);
    commonResponse.setResponseType("ChangePassword");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> uploadMedicalTestResponse(medicalTestRequestID, imagesCount, photos) async {
    final response = await helper.multiPartRequest(ConstAPIUrls.uploadMedicalTest,
        medicalTestRequestID, imagesCount, photos,
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("UploadMedicalTest");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> getSystemConfigurationsResponse() async {
    final response = await helper.get(ConstAPIUrls.getSystemConfigurations);
    commonResponse.setResponseType("SystemConfigurations");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> forgetPasswordResponse(String email) async {
    final response = await helper.post(ConstAPIUrls.forgetPassword, body: {'email': email});
    print(response);
    commonResponse.setResponseType("ForgetPassword");
    return commonResponse.fromJson(response);
  }

  Future<CommonResponse> getNotificationsResponse() async {
    final response = await helper.get(ConstAPIUrls.getNotifications + await (getPatientID() as FutureOr<String>),
        headers: {'Authorization': await (getAccessToken() as FutureOr<String>), 'Referer': 'https://www.flexsolution.biz'});
    print(response);
    commonResponse.setResponseType("Notifications");
    return commonResponse.fromJson(response);

  }

}
