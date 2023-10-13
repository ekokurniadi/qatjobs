import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/jobs_skill/domain/repositories/jobs_skill_repository.dart";
import "package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart";

class GetJobsSkillUseCase implements UseCase<List<JobsSkillModel>, NoParams> {
  final JobsSkillRepository _jobsSkillRepository;

  GetJobsSkillUseCase({
    required JobsSkillRepository jobsSkillRepository,
  }) : _jobsSkillRepository = jobsSkillRepository;

  @override
  Future<Either<Failures, List<JobsSkillModel>>> call(NoParams params) async {
    return await _jobsSkillRepository.getJobsSkill(params);
  }
}
