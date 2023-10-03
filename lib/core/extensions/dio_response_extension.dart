import 'dart:io';

import 'package:dio/dio.dart';

extension DioResponse on Response<dynamic> {
  bool get isOk {
    if (statusCode == HttpStatus.ok ||
        statusCode == HttpStatus.created ||
        statusCode == HttpStatus.accepted) {
      if (data != null) {
        return true;
      }
      return false;
    }
    return false;
  }
}
