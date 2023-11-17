import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_stages/domain/repositories/job_stages_repository.dart";

@injectable
class DeleteJobStagesUseCase implements UseCase<bool, int> {
  final JobStagesRepository _jobStagesRepository;

  DeleteJobStagesUseCase({
    required JobStagesRepository jobStagesRepository,
  }) : _jobStagesRepository = jobStagesRepository;

  @override
  Future<Either<Failures, bool>> call(int params) async {
    return await _jobStagesRepository.deleteJobStages(params);
  }
}
