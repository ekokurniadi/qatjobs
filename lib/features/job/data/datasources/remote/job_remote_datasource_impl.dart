import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/helpers/global_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/job_filter.codegen.dart";
import "job_remote_datasource.dart";
import "package:qatjobs/features/job/data/models/job_model.codegen.dart";

@LazySingleton(as: JobRemoteDataSource)
class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  const JobRemoteDataSourceImpl(this._dio);

  final Dio _dio;
  @override
  Future<Either<Failures, List<JobModel>>> getAJob(
      JobFilterModel params) async {
    try {
      final response = await _dio.post(
        URLConstant.jobSearch,
        data: params.toJson(),
      );

      if (response.isOk) {
        if (!GlobalHelper.isEmpty(response.data['data'])) {
          final result = List<JobModel>.from(
            response.data['data'].map(
              (e) => JobModel.fromJson(e),
            ),
          );
          return right(result);
        }
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
