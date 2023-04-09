
import 'package:dio/dio.dart';

import '../responses/api_response.dart';
import 'api_service.dart';


class ApiGateway {
  final ApiService? _apiService;

  ApiGateway(this._apiService);

  Future<ApiResponse> getCall({
    String? endPoint,
    bool isParam = false,
  }) async {
    try {
      Map<String, dynamic> headers = {};
      headers["Content-Type"] = "application/json";
      headers['Authorization'] = 'Bearer eyJhdWQiOiI1IiwianRpIjoiMDg4MmFiYjlmNGU1MjIyY2MyNjc4Y2FiYTQwOGY2MjU4Yzk5YTllN2ZkYzI0NWQ4NDMxMTQ4ZWMz';

      final response = await _apiService?.dio.get(
        endPoint!,
        options: Options(
          method: "GET",
          headers: headers,
        ),
      );
      return ApiResponse.success(response: response);
    } on DioError catch (e) {
      print("Exception $endPoint $e");
      return ApiResponse.failure(error: e);
    }
  }

  Future<ApiResponse> postCall({
    Map<String, dynamic>? request,
    String? endPoint,
    Map<String, dynamic>? header,
  }) async {
    try {
      Map<String, dynamic> _header = {"Content-Type": "application/json"};
      if (header != null) {
        _header.addAll(header);
      }
      final response = await _apiService?.dio.post(
        endPoint!,
        data: request,
        options: Options(
          method: "POST",
          contentType: "application/json",
          responseType: ResponseType.json,
          headers: _header,
        ),
      );
      return ApiResponse.success(response: response);
    } on DioError catch (e) {
      print("Exception $endPoint $e");
      return ApiResponse.failure(error: e);
    }
  }
}
