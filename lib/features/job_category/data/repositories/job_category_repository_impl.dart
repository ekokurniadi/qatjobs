import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_category/domain/repositories/job_category_repository.dart";
import "package:qatjobs/features/job_category/data/datasources/remote/job_category_remote_datasource.dart";
import "package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart";

class JobCategoryRepositoryImpl implements JobCategoryRepository {
  final JobCategoryRemoteDataSource _jobCategoryRemoteDataSource;

  const JobCategoryRepositoryImpl({
    required JobCategoryRemoteDataSource jobCategoryRemoteDataSource,
  }) : _jobCategoryRemoteDataSource = jobCategoryRemoteDataSource;

  @override
  Future<Either<Failures, List<JobCategoryModel>>> getJobCategory(
      NoParams params) async {
    return await _jobCategoryRemoteDataSource.getJobCategory(params);
  }
}
