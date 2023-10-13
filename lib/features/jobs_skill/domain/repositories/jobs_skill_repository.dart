import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart";

abstract class JobsSkillRepository {
	Future<Either<Failures,List<JobsSkillModel>>> getJobsSkill(NoParams params);
}
