import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_type/data/models/jobs_type_model.codegen.dart";
import 'job_type_remote_datasource.dart';

@LazySingleton(as: JobTypeRemoteDataSource)
class JobTypeRemoteDataSourceImpl implements JobTypeRemoteDataSource {
  final Dio _dio;
  const JobTypeRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<JobTypeModel>>> getJobType(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.jobTypes);
      if (response.isOk) {
        return right(
          List<JobTypeModel>.from(
            response.data.map(
              (e) => JobTypeModel.fromJson(e),
            ),
          ),
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
