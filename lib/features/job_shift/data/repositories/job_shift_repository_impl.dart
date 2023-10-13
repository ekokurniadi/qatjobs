import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/features/job_shift/data/datasources/remote/job_shift_remote_datasource.dart";
import "package:qatjobs/features/job_shift/data/models/job_shift_model.codegen.dart";
import "package:qatjobs/features/job_shift/domain/repositories/job_shift_repository.dart";

class JobShiftRepositoryImpl implements JobShiftRepository {
  final JobShiftRemoteDataSource _jobShiftRemoteDataSource;

  const JobShiftRepositoryImpl({
    required JobShiftRemoteDataSource jobShiftRemoteDataSource,
  }) : _jobShiftRemoteDataSource = jobShiftRemoteDataSource;

  @override
  Future<Either<Failures, JobShiftModel>> getJobShift(
      JobShiftModel params) async {
    return await _jobShiftRemoteDataSource.getJobShift(params);
  }
}
