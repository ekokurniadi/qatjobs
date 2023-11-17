import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart";
import "package:qatjobs/features/job_stages/domain/usecases/add_job_stages_usecase.dart";

abstract class JobStagesRemoteDataSource {
  Future<Either<Failures, List<JobStagesModel>>> getJobStages(NoParams params);
  Future<Either<Failures, bool>> addJobStages(JobStagesRequestParams params);
  Future<Either<Failures, bool>> updateJobStages(JobStagesRequestParams params);
  Future<Either<Failures, bool>> deleteJobStages(int params);
}
