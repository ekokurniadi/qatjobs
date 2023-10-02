import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio get dio => DioHelper.dio!;

  @lazySingleton
  Connectivity get connectivity => Connectivity();
  
}
