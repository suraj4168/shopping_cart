
import 'package:dio/dio.dart';

import '../../util/log_print.dart';

class ApiService {
  static ApiService? _instance;

  factory ApiService() => _instance ??= ApiService._();

  ApiService._();

  static const String USER_AGENT = "user-agent";
  static const _timeout = 600000;

  bool get isInDebugMode {
    bool inDebugMode = false;
    assert(inDebugMode = true);
    return inDebugMode;
  }

  Dio get dio => _dio();

  Dio _dio() {
    final options = BaseOptions(
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
    );

    var dio = Dio(options);
    dio.interceptors.add(intercepter(dio));
    // dio.interceptors.add(userAgentInterceptor(dio));
    return dio;
  }

  InterceptorsWrapper intercepter(Dio dio) => InterceptorsWrapper(
          onResponse: (Response response, ResponseInterceptorHandler handler) {
        if (ApiService().isInDebugMode) {
          LogPrint("Api - Response headers");
          response.headers.forEach((k, v) {
            v.forEach((s) => print("$k , $s"));
          });
          LogPrint("Api - Response: ${response.data}");
        }
        return handler.next(response);
      }, onRequest:
              (RequestOptions options, RequestInterceptorHandler handler) {
        final uri = options.uri.toString();

        if (ApiService().isInDebugMode) {
          LogPrint("Api - URL: ${uri.toString()}");
          LogPrint("Api - headers: ${options.headers}");
          LogPrint("Api - Request Body: ${options.data}");
          LogPrint("Api - Method: ${options.method}");
        }
        return handler.next(options);
      }, onError: (DioError e, handler) {
        return handler.next(e);
      });
}

