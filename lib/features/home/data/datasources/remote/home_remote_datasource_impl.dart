import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:qatjobs/features/home/data/models/home_models.codegen.dart';

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final Dio _dio;
  const HomeRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, HomeModels>> getFrontData(NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.homeFrontData);

      if (response.isOk) {
        return right(HomeModels.fromJson(response.data));
      }

      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    }
  }
}
