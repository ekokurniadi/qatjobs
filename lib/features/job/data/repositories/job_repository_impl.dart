import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/job_filter.codegen.dart";
import "package:qatjobs/features/job/domain/repositories/job_repository.dart";
import "package:qatjobs/features/job/data/datasources/remote/job_remote_datasource.dart";
import "package:qatjobs/features/job/data/models/job_model.codegen.dart";

@LazySingleton(as:JobRepository)
class JobRepositoryImpl implements JobRepository {
  final JobRemoteDataSource _jobRemoteDataSource;

  const JobRepositoryImpl({
    required JobRemoteDataSource jobRemoteDataSource,
  }) : _jobRemoteDataSource = jobRemoteDataSource;

  @override
  Future<Either<Failures, List<JobModel>>> getAJob(JobFilterModel params) async {
    return await _jobRemoteDataSource.getAJob(params);
  }
}
