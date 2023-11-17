import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart";
import "package:qatjobs/features/job_stages/domain/usecases/add_job_stages_usecase.dart";
import "job_stages_remote_datasource.dart";

@LazySingleton(as: JobStagesRemoteDataSource)
class JobStagesRemoteDataSourceImpl implements JobStagesRemoteDataSource {
  final Dio _dio;
  const JobStagesRemoteDataSourceImpl(this._dio);

  @override
  Future<Either<Failures, List<JobStagesModel>>> getJobStages(
      NoParams params) async {
    try {
      List<JobStagesModel> result = [];
      final response = await _dio.get(URLConstant.employerJobStages);
      if (response.isOk) {
        result = List<JobStagesModel>.from(
          response.data.map(
            (e) => JobStagesModel.fromJson(e),
          ),
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
  Future<Either<Failures, bool>> addJobStages(
      JobStagesRequestParams params) async {
    try {
      final response = await _dio.post(
        URLConstant.employerJobStages,
        data: params.toJson(),
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
  Future<Either<Failures, bool>> updateJobStages(
      JobStagesRequestParams params) async {
    try {
      final response = await _dio.put(
        '${URLConstant.employerJobStages}/${params.id}',
        data: params.toJson(),
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
  Future<Either<Failures, bool>> deleteJobStages(int params) async {
    try {
      final response = await _dio.delete(
        '${URLConstant.employerJobStages}/$params',
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
