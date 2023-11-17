import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_stages/data/datasources/remote/job_stages_remote_datasource.dart";
import "package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart";
import "package:qatjobs/features/job_stages/domain/repositories/job_stages_repository.dart";
import "package:qatjobs/features/job_stages/domain/usecases/add_job_stages_usecase.dart";

@LazySingleton(as: JobStagesRepository)
class JobStagesRepositoryImpl implements JobStagesRepository {
  final JobStagesRemoteDataSource _jobStagesRemoteDataSource;

  const JobStagesRepositoryImpl({
    required JobStagesRemoteDataSource jobStagesRemoteDataSource,
  }) : _jobStagesRemoteDataSource = jobStagesRemoteDataSource;

  @override
  Future<Either<Failures, List<JobStagesModel>>> getJobStages(
      NoParams params) async {
    return await _jobStagesRemoteDataSource.getJobStages(params);
  }

  @override
  Future<Either<Failures, bool>> addJobStages(
      JobStagesRequestParams params) async {
    return await _jobStagesRemoteDataSource.addJobStages(params);
  }

  @override
  Future<Either<Failures, bool>> updateJobStages(
      JobStagesRequestParams params) async {
    return await _jobStagesRemoteDataSource.updateJobStages(params);
  }

  @override
  Future<Either<Failures, bool>> deleteJobStages(int params) async {
    return await _jobStagesRemoteDataSource.deleteJobStages(params);
  }
}
