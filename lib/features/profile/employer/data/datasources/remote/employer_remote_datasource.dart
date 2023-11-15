import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_profile_usecase.dart';

abstract class EmployerRemoteDataSource {
  Future<Either<Failures, CompanyModel>> getProfileEmployer(
    NoParams params,
  );
  Future<Either<Failures, bool>> updateProfile(
    EmployerProfileRequestParams params,
  );
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  );
  Future<Either<Failures, bool>> updateCompanyProfile(CompanyModel params);
}

@LazySingleton(as: EmployerRemoteDataSource)
class EmployerRemoteDataSourceImpl implements EmployerRemoteDataSource {
  final Dio _dio;
  const EmployerRemoteDataSourceImpl(this._dio);

  @override
  Future<Either<Failures, CompanyModel>> getProfileEmployer(
    NoParams params,
  ) async {
    try {
      final response = await _dio.get(URLConstant.employerProfileCompany);
      if (response.isOk) {
        final result = CompanyModel.fromJson(
          response.data['companyDetail'],
        );
        return right(result);
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
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> updateProfile(
    EmployerProfileRequestParams params,
  ) async {
    try {
      String fileName = '';
      Map<String, dynamic> paramToSend = {
        'first_name': params.firstName,
        'email': params.email,
      };

      if (params.phone != null) {
        paramToSend['phone'] = params.phone;
      }

      if (params.image != null) {
        fileName = params.image!.path.split('/').last;
        paramToSend['image'] = await MultipartFile.fromFile(
          params.image!.path,
          filename: fileName,
        );
      }

      final response = await _dio.post(
        URLConstant.employerProfileUpdate,
        data: FormData.fromMap(paramToSend),
      );
      if (response.isOk) {
        return right(true);
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
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  ) async {
    try {
      final formData = FormData.fromMap(params.toJson());

      final response = await _dio.post(
        URLConstant.employerProfileChangePassword,
        data: formData,
      );
      if (response.isOk) {
        return right(true);
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
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failures, bool>> updateCompanyProfile(
      CompanyModel params) async {
    try {
      final newParam = <String, dynamic>{};
      newParam['user_id'] = params.userId;
      newParam['name'] = params.user?.firstName ?? '';
      newParam['email'] = params.user?.email ?? '';
      newParam['phone'] = params.user?.phone ?? '';
      newParam['ceo'] = params.ceo ?? '';
      newParam['details'] = params.details ?? 'xxx';
      newParam['industry_id'] = params.industryId ?? 0;
      newParam['ownership_type_id'] = params.ownershipTypeId ?? 0;
      newParam['established_in'] = params.establishedIn ?? 0;
      newParam['website'] = params.website ?? '';
      newParam['location'] = params.location ?? '';
      newParam['no_of_offices'] = params.noOfOffices ?? 0;
      newParam['facebook_url'] = params.user?.facebookUrl ?? '';
      newParam['twitter_url'] = params.user?.twitterUrl ?? '';
      newParam['linkedin_url'] = params.user?.linkedinUrl ?? '';
      newParam['google_plus_url'] = params.user?.googlePlusUrl ?? '';
      newParam['pinterest_url'] = params.user?.pinterestUrl ?? '';

      final formData = FormData.fromMap(newParam);
      final response = await _dio.put(
        URLConstant.employerProfileCompany,
        data: formData,
      );
      if (response.isOk) {
        return right(true);
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
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
