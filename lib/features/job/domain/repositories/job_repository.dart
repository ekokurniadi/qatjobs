import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/features/job/data/models/job_filter.codegen.dart";
import "package:qatjobs/features/job/data/models/job_model.codegen.dart";

abstract class JobRepository {
	Future<Either<Failures,List<JobModel>>> getAJob(JobFilterModel params);
}
