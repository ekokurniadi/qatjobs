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

  static String _handleError(int? statusCode, Response? error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return error?.statusMessage ?? 'Not Found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      case 302:
        return 'Already exist';
      case 422:
        return error?.statusMessage ?? 'Error';
      default:
        return 'Oops something went wrong';
    }
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
