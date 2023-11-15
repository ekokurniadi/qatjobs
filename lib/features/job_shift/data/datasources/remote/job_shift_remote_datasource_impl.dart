import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/features/job_shift/data/models/job_shift_model.codegen.dart";
import "job_shift_remote_datasource.dart";

class JobShiftRemoteDataSourceImpl implements JobShiftRemoteDataSource {
  @override
  Future<Either<Failures, JobShiftModel>> getJobShift(
      JobShiftModel params) async {
  
    throw UnimplementedError();
  }
}
