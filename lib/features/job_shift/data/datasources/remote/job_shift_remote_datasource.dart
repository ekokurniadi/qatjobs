import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/features/job_shift/data/models/job_shift_model.codegen.dart";

abstract class JobShiftRemoteDataSource {
	Future<Either<Failures,JobShiftModel>> getJobShift(JobShiftModel params);
}
