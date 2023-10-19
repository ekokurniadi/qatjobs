import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "jobs_skill_remote_datasource.dart";
import "package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart";

@LazySingleton(as: JobsSkillRemoteDataSource)
class JobsSkillRemoteDataSourceImpl implements JobsSkillRemoteDataSource {
  final Dio _dio;
  const JobsSkillRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<JobsSkillModel>>> getJobsSkill(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.skill);
      if (response.isOk) {
        return right(
          List<JobsSkillModel>.from(
            response.data.map(
              (e) => JobsSkillModel.fromJson(e),
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
