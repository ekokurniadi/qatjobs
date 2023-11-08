import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/applied_job_model.codegen.dart";
import "package:qatjobs/features/job/data/models/favorite_job_model.codegen.dart";
import "package:qatjobs/features/job/data/models/job_alert_request_params.codegen.dart";
import "package:qatjobs/features/job/data/models/job_alerts_model.codegen.dart";
import "package:qatjobs/features/job/data/models/job_filter.codegen.dart";
import "package:qatjobs/features/job/data/models/job_model.codegen.dart";
import "package:qatjobs/features/job/domain/usecases/apply_job_usecase.dart";
import "package:qatjobs/features/job/domain/usecases/save_to_favorite_job_usecase.dart";

abstract class JobRemoteDataSource {
  Future<Either<Failures, List<JobModel>>> getAJob(JobFilterModel params);
  Future<Either<Failures, List<FavoriteJobModel>>> getFavoriteJob(
      NoParams params);
  Future<Either<Failures, bool>> saveToFavorite(
      FavoriteJobRequestParams params);
  Future<Either<Failures, bool>> deleteFavoriteJob(int params);
  Future<Either<Failures, List<AppliedJobModel>>> getAppliedJob(
      NoParams params);
  Future<Either<Failures, JobAlertsModel>> getJobAlert(NoParams params);
  Future<Either<Failures, bool>> addJobAlert(JobAlertRequestParams params);
  Future<Either<Failures, bool>> applyJob(ApplyJobRequestParams params);
}
