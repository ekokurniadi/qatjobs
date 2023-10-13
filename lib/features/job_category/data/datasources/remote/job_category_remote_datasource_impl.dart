import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "job_category_remote_datasource.dart";
import "package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart";

class JobCategoryRemoteDataSourceImpl implements JobCategoryRemoteDataSource {
	@override
	Future<Either<Failures,List<JobCategoryModel>>> getJobCategory(NoParams params) async{
		// TODO: implement execute 
		throw UnimplementedError();
	}
}
