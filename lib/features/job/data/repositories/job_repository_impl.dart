import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/applied_job_model.codegen.dart";
import "package:qatjobs/features/job/data/models/favorite_job_model.codegen.dart";
import "package:qatjobs/features/job/data/models/job_alert_request_params.codegen.dart";
import "package:qatjobs/features/job/data/models/job_alerts_model.codegen.dart";
import "package:qatjobs/features/job/data/models/job_filter.codegen.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";
import "package:qatjobs/features/job/data/datasources/remote/job_remote_datasource.dart";
import "package:qatjobs/features/job/data/models/job_model.codegen.dart";
import "package:qatjobs/features/job/domain/usecases/save_to_favorite_job_usecase.dart";

@LazySingleton(as: JobRepository)
class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource _jobRemoteDataSource;

  const JobRepositoryImpl({
    required JobRemoteDataSource jobRemoteDataSource,
  }) : _jobRemoteDataSource = jobRemoteDataSource;

  @override
  Future<Either<Failures, List<JobModel>>> getAJob(
      JobFilterModel params) async {
    return await _jobRemoteDataSource.getAJob(params);
  }

  @override
  Future<Either<Failures, List<FavoriteJobModel>>> getFavoriteJob(
      NoParams params) async {
    return await _jobRemoteDataSource.getFavoriteJob(params);
  }

  @override
  Future<Either<Failures, bool>> saveToFavorite(
      FavoriteJobRequestParams params) async {
    return await _jobRemoteDataSource.saveToFavorite(params);
  }

  @override
  Future<Either<Failures, bool>> deleteFavoriteJob(int params) async {
    return await _jobRemoteDataSource.deleteFavoriteJob(params);
  }

  @override
  Future<Either<Failures, List<AppliedJobModel>>> getAppliedJob(
      NoParams params) async {
    return await _jobRemoteDataSource.getAppliedJob(params);
  }

  @override
  Future<Either<Failures, JobAlertsModel>> getJobAlert(NoParams params) async {
    return await _jobRemoteDataSource.getJobAlert(params);
  }

  @override
  Future<Either<Failures, bool>> addJobAlert(
      JobAlertRequestParams params) async {
    return await _jobRemoteDataSource.addJobAlert(params);
  }
}
