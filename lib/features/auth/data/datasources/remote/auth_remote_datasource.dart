import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/app_constant.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/features/auth/data/models/login_model.codegen.dart';
import 'package:qatjobs/features/auth/domain/usecases/login_usecase.dart';
import 'package:qatjobs/features/auth/domain/usecases/register_usecase.dart';
import 'package:qatjobs/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failures, LoginModel>> login(LoginRequestParams params);
  Future<Either<Failures, bool>> register(RegisterRequestParam params);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Either<Failures, LoginModel>> login(LoginRequestParams params) async {
    try {
      final formData = FormData.fromMap(params.toJson());
      final response = await _dio.post(
        URLConstant.login,
        data: formData,
        
      );

      if (response.isOk) {
        final result = LoginModel.fromJson(response.data);
        await getIt<SharedPreferences>().setString(
          AppConstant.prefKeyUserLogin,
          jsonEncode(result.user.toJson()),
        );

        await getIt<SharedPreferences>().setString(
          AppConstant.prefKeyToken,
          result.accessToken,
        );

        DioHelper.setDioHeader(result.accessToken);

        if (result.roles.isNotEmpty) {
          await getIt<SharedPreferences>().setString(
            AppConstant.prefKeyRole,
            result.roles.first,
          );
        }

        if (params.isRememberMe ?? false) {
          await getIt<SharedPreferences>().setBool(
            AppConstant.prefIsRememberMeKey,
            true,
          );
          await getIt<SharedPreferences>().setString(
            AppConstant.prefEmailKey,
            params.email,
          );
          await getIt<SharedPreferences>().setString(
            AppConstant.prefPasswordKey,
            params.password,
          );

          if (result.roles.isNotEmpty) {
            await getIt<SharedPreferences>().setInt(
              AppConstant.prefSelectedRoledKey,
              result.roles.first.toLowerCase() == AppConstant.roleCandidate
                  ? 1
                  : 2,
            );
          }
        }

        return right(result);
      }

      return left(
        ServerFailure(errorMessage: response.data['message']),
      );
    } on DioError catch (e) {
      return left(ServerFailure(errorMessage: DioHelper.formatException(e)));
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> register(
    RegisterRequestParam params,
  ) async {
    try {
      final formData = FormData.fromMap(params.toJson());
      final response = await _dio.post(
        URLConstant.register,
        data: formData,
      );

      if (response.isOk) {
        return right(response.isOk);
      }

      return left(
        ServerFailure(errorMessage: response.data['message']),
      );
    } on DioError catch (e) {
      return left(
        ServerFailure(errorMessage: DioHelper.formatException(e)),
      );
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
