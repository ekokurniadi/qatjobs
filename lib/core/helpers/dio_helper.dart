import 'dart:io';
import 'dart:developer';
import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void initialDio(String baseUrl) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 20000,
        receiveTimeout: 40000,
        contentType: 'application/json',
        responseType: ResponseType.json,
      ),
    );
  }

  static void setDioLogger(String baseUrl) {
    dio!.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, responseInterceptorHandler) {
          log('${response.statusCode} - ${response.data.toString()}\n');
          return responseInterceptorHandler.next(response);
        },
        onRequest: (request, requestInterceptorHandler) {
          log('${request.method} - ${request.path} - ${request.data} - ${request.queryParameters}');
          return requestInterceptorHandler.next(request);
        },
        onError: (DioError error, errorInterceptor) {
          log(error.message);
          return errorInterceptor.next(error);
        },
      ),
    );
  }

  static setDioHeader(String? token) {
    dio!.options.headers = {HttpHeaders.authorizationHeader: 'Bearer $token'};
    dio!.options.headers['X-Requested-With'] = 'XMLHttpRequest';
    log('token user: $token');
  }

  static String _handleError(int? statusCode, Response? error) {
   return error?.data['message'] ?? 'Something when wrong';
  }

  static String formatException(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return "Request to API server was cancelled";

      case DioErrorType.connectTimeout:
        return "Connection timeout with API server";

      case DioErrorType.receiveTimeout:
        return "Receive timeout in connection with API server";

      case DioErrorType.response:
        return _handleError(
          dioError.response?.statusCode,
          dioError.response,
        );

      case DioErrorType.sendTimeout:
        return "Send timeout in connection with API server";

      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          return 'No Internet';
        }
        return "Unexpected error occurred";

      default:
        return "Something went wrong";
    }
  }
}
