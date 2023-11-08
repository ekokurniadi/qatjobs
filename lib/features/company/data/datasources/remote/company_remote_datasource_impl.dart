import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/company/domain/usecases/add_favorite_company_usecase.dart";
import "package:qatjobs/features/company/domain/usecases/get_company_usecase.dart";
import "package:qatjobs/features/company/domain/usecases/report_company_usecase.dart";
import "company_remote_datasource.dart";
import "package:qatjobs/features/company/data/models/company_model.codegen.dart";

@LazySingleton(as: CompanyRemoteDataSource)
class CompanyRemoteDataSourceImpl implements CompanyRemoteDataSource {
  const CompanyRemoteDataSourceImpl(this._dio);
  final Dio _dio;

  @override
  Future<Either<Failures, List<CompanyModel>>> getCompany(
      CompanyRequestParams params) async {
    try {
      final response =
          await _dio.post(URLConstant.companies, data: params.toJson());
      if (response.isOk) {
        return right(
          List.from(response.data['data'].map((e) => CompanyModel.fromJson(e))),
        );
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
  Future<Either<Failures, bool>> addFavoriteCompany(
      AddFavoriteCompanyRequestParams params) async {
    try {
      final response = await _dio.post(URLConstant.candidateFavoriteCompany,
          data: params.toJson());
      if (response.isOk) {
        return right(response.data['data']);
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
  Future<Either<Failures, bool>> report(
      ReportCompanyRequestParams params) async {
    try {
      final response = await _dio.post(
          URLConstant.candidateReportCompany(params.id),
          data: params.toJson());
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
  Future<Either<Failures, List<CompanyModel>>> getFavoriteCompany(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.candidateFavoriteCompany);
      if (response.isOk) {
        return right(
          List.from(response.data.map((e) => CompanyModel.fromJson(e['company']))),
        );
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
