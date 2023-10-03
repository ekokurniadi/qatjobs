import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/features/auth/data/models/login_model.codegen.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, LoginModel>> login(LoginRequestParams params);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Either<Failures, LoginModel>> login(LoginRequestParams params) async {
    try {
      final response = await _dio.post(
        URLConstant.login,
        data: params.toJson(),
      );

      if (response.isOk) {
        return right(LoginModel.fromJson(response.data));
      }

      return left(
        ServerFailure(errorMessage: response.data['message']),
      );
    } on DioError catch (e) {
      return left(
        ServerFailure(errorMessage: DioHelper.formatException(e)),
      );
    }
  }
}
