import 'package:dio/dio.dart';

class ApiResponse<T> {
  T? body;
  bool success = false;
  String? error = "";

  ApiResponse.success({T? response}) {
    try {
      body = response is Response ? response.data : response;
      success = true;
    } catch (e) {
      print("error in success ${e.toString()}");
    }
  }

  ApiResponse.failure({DioError? error}) {
    if (error is DioError) {
      body = error.response?.data;
    }
  }

  ApiResponse.error({String? error}) {
    this.error = error;
  }
}
