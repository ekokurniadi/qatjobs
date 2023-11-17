import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart";
import "package:qatjobs/features/job_stages/domain/repositories/job_stages_repository.dart";

@injectable
class GetJobStagesUseCase implements UseCase<List<JobStagesModel>, NoParams> {
  final JobStagesRepository _jobStagesRepository;

  GetJobStagesUseCase({
    required JobStagesRepository jobStagesRepository,
  }) : _jobStagesRepository = jobStagesRepository;

  @override
  Future<Either<Failures, List<JobStagesModel>>> call(NoParams params) async {
    return await _jobStagesRepository.getJobStages(params);
  }
}
