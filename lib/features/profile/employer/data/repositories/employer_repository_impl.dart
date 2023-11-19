import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/company/data/models/company_model.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/datasources/remote/employer_remote_datasource.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_application_models.codegen.dart';
import 'package:qatjobs/features/profile/employer/data/models/job_request_params.codegen.dart';
import 'package:qatjobs/features/profile/employer/domain/repositories/employer_repository.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/change_password_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_job_status_usecase.dart';
import 'package:qatjobs/features/profile/employer/domain/usecases/update_profile_usecase.dart';

@LazySingleton(as: EmployerRepository)
class EmployerRepositoryImpl implements EmployerRepository {
  final EmployerRemoteDataSource _dataSource;
  const EmployerRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failures, CompanyModel>> getProfileEmployer(
    NoParams params,
  ) async {
    return await _dataSource.getProfileEmployer(params);
  }

  @override
  Future<Either<Failures, bool>> updateProfile(
      EmployerProfileRequestParams params) async {
    return await _dataSource.updateProfile(params);
  }

  @override
  Future<Either<Failures, bool>> changePassword(
    ChangePasswordRequestParams params,
  ) async {
    return await _dataSource.changePassword(params);
  }

  @override
  Future<Either<Failures, bool>> updateCompanyProfile(
      CompanyModel params) async {
    return await _dataSource.updateCompanyProfile(params);
  }

  @override
  Future<Either<Failures, List<JobModel>>> getJobs(
      JobRequestParams params) async {
    return await _dataSource.getJobs(params);
  }

  @override
  Future<Either<Failures, bool>> updateJobStatus(
      UpdateJobStatusParams params) async {
    return await _dataSource.updateJobStatus(params);
  }

  @override
  Future<Either<Failures, List<JobApplicationModel>>> getJobApplicant(
      int id) async {
    return await _dataSource.getJobApplicant(id);
  }

  @override
  Future<Either<Failures, bool>> updateJob(JobModel params) async {
    return await _dataSource.updateJob(params);
  }
}
