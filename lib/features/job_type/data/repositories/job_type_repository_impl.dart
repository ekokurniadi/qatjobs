import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_type/data/datasources/remote/job_type_remote_datasource.dart";
import "package:qatjobs/features/job_type/data/models/jobs_type_model.codegen.dart";
import "package:qatjobs/features/job_type/domain/repositories/job_type_repository.dart";

@LazySingleton(as: JobTypeRepository)
class JobTypeRepositoryImpl implements JobTypeRepository {
  final JobTypeRemoteDataSource _jobTypeRemoteDataSource;

  const JobTypeRepositoryImpl({
    required JobTypeRemoteDataSource jobTypeRemoteDataSource,
  }) : _jobTypeRemoteDataSource = jobTypeRemoteDataSource;

  @override
  Future<Either<Failures, List<JobTypeModel>>> getJobType(
      NoParams params) async {
    return await _jobTypeRemoteDataSource.getJobType(params);
  }
}
