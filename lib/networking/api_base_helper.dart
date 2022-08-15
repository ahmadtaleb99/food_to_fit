import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:food_to_fit/networking/api_exceptions.dart';
import 'dart:async';
import 'package:food_to_fit/app_constants.dart';
import 'package:food_to_fit/sharedPreferences.dart';

class ApiBaseHelper {
  final String baseUrl = ConstAPIUrls.baseURL;

  Future getPatientID() async {
    return await SharedPreferencesSingleton().getStringValuesSF('patient_id');
  }

  Future<dynamic> get(String url, {Map<String, String>? headers}) async {
    final uri = Uri.parse(baseUrl + url);

    print('Api Get, url $url');
    var responseJson;
    try {
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 60));
      responseJson = returnResponse(response);
    } on TimeoutException catch (_) {
      throw FetchDataException('No Internet connection'.tr());
    } on SocketException catch (_) {
      throw FetchDataException('timeout-error'.tr());
    } catch (e) {
      print(e);
      throw FetchDataException('Something went wrong!'.tr());
    }

    print('api get received!');
    return responseJson;
  }

  Future<dynamic> post(String url,
      {Map<String, dynamic>? body, Map<String, String>? headers}) async {
    print('Api Post, url $url');
    print(body);
    final uri = Uri.parse(baseUrl + url);

    var responseJson;
    try {
      final response =
          await http.post(uri, body: body, headers: headers);

      responseJson = returnResponse(response);
    } on TimeoutException catch (_) {
      throw FetchDataException('Server Timed out waiting for the response'.tr());
    } on SocketException catch (_) {
      throw FetchDataException('No Internet connection'.tr());
    } catch (e) {
      print(e);
      throw FetchDataException('Something went wrong!'.tr());
    }
    print('api get received!');
    return responseJson;
  }

  Future<dynamic> multiPartRequest(
      String url, medicalTestRequestID, imagesCount, photos,
      {required Map<String, String> headers}) async {
    print('Api MultiPart Post, url $url');
    var responseJson;
    try {
      final uri = Uri.parse(baseUrl + url);
      http.MultipartRequest request =  http.MultipartRequest('POST', uri);
      request.headers.addAll(headers);
      request.fields['imgs_count'] = imagesCount.toString();
      request.fields['medical_test_id'] = medicalTestRequestID.toString();
      for (int i = 0; i < imagesCount; i++) {
        request.files.add(await http.MultipartFile.fromPath(
            'photos' + i.toString(), photos[i].path));
      }

      http.Response response =
          await http.Response.fromStream(await request.send());
      responseJson = returnResponse(response);
    } on TimeoutException catch (_) {
      throw FetchDataException('Server Timed out waiting for the response'.tr());
    } on SocketException catch (_) {
      throw FetchDataException('No Internet connection'.tr());
    } catch (e) {
      print(e);
      print('error catched');
      throw FetchDataException('Something went wrong!'.tr());
    }
    print('api get received!');
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
