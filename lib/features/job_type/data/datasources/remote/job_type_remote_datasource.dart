import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_type/data/models/jobs_type_model.codegen.dart";

abstract class JobTypeRemoteDataSource {
  Future<Either<Failures, List<JobTypeModel>>> getJobType(NoParams params);
}
