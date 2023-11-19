import 'package:dartz/dartz.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_application_models.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_request_params.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_job_status_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_profile_usecase.dart';

abstract class EmployerRepository {
  Future<Either<Failures, CompanyModel>> getProfileEmployer(NoParams params);
  Future<Either<Failures, bool>> updateProfile(
    EmployerProfileRequestParams params,
  );
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  );
  Future<Either<Failures, bool>> updateCompanyProfile(
    CompanyModel params,
  );
  Future<Either<Failures, List<JobModel>>> getJobs(JobRequestParams params);
  Future<Either<Failures, bool>> updateJobStatus(
    UpdateJobStatusParams params,
  );
  Future<Either<Failures, List<JobApplicationModel>>> getJobApplicant(int id);
}
