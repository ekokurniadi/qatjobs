import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart";

abstract class JobCategoryRepository {
	Future<Either<Failures,List<JobCategoryModel>>> getJobCategory(NoParams params);
}
