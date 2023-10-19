import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_category/domain/repositories/job_category_repository.dart";
import "package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart";

@injectable
class GetJobCategoryUseCase
    implements UseCase<List<JobCategoryModel>, NoParams> {
  final JobCategoryRepository _jobCategoryRepository;

  GetJobCategoryUseCase({
    required JobCategoryRepository jobCategoryRepository,
  }) : _jobCategoryRepository = jobCategoryRepository;

  @override
  Future<Either<Failures, List<JobCategoryModel>>> call(NoParams params) async {
    return await _jobCategoryRepository.getJobCategory(params);
  }
}
