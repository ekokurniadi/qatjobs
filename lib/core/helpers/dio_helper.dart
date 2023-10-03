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
    log('token user: $token');
  }

  static String formatException(DioError e) {
    String message = "Failed to process your request";
    // Handle DioError type-specific errors
    if (e.response != null) {
      log('DioError response status: ${e.response?.statusCode}');
      log('DioError response data: ${e.response?.data}');
      log('DioError response headers: ${e.response?.headers}');
      if (e.response?.data != null) {
        message = e.response?.data['message'] ?? 'Something went wrong';
      }
    } else {
      log('DioError: ${e.message}');
      message = e.message;
    }
    return message;
  }
}
