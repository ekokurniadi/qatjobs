import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "jobs_skill_remote_datasource.dart";
import "package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart";

class JobsSkillRemoteDataSourceImpl implements JobsSkillRemoteDataSource {
  @override
  Future<Either<Failures, List<JobsSkillModel>>> getJobsSkill(
      NoParams params) async {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
