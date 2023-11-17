import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_stages/domain/repositories/job_stages_repository.dart";
import "package:qatjobs/features/job_stages/domain/usecases/add_job_stages_usecase.dart";

@injectable
class UpdateJobStagesUseCase implements UseCase<bool, JobStagesRequestParams> {
  final JobStagesRepository _jobStagesRepository;

  UpdateJobStagesUseCase({
    required JobStagesRepository jobStagesRepository,
  }) : _jobStagesRepository = jobStagesRepository;

  @override
  Future<Either<Failures, bool>> call(JobStagesRequestParams params) async {
    return await _jobStagesRepository.updateJobStages(params);
  }
}
