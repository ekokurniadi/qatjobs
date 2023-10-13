import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/jobs_skill/domain/repositories/jobs_skill_repository.dart";
import "package:qatjobs/features/jobs_skill/data/datasources/remote/jobs_skill_remote_datasource.dart";
import "package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart";

class JobsSkillRepositoryImpl implements JobsSkillRepository {
  final JobsSkillRemoteDataSource _jobsSkillRemoteDataSource;

  const JobsSkillRepositoryImpl({
    required JobsSkillRemoteDataSource jobsSkillRemoteDataSource,
  }) : _jobsSkillRemoteDataSource = jobsSkillRemoteDataSource;

  @override
  Future<Either<Failures, List<JobsSkillModel>>> getJobsSkill(
      NoParams params) async {
    return await _jobsSkillRemoteDataSource.getJobsSkill(params);
  }
}
