import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "active_featured_remote_datasource.dart";
import "package:qatjobs/features/active_featured/data/models/active_featured_model.codegen.dart";

class ActiveFeaturedRemoteDataSourceImpl implements ActiveFeaturedRemoteDataSource {
	@override
	Future<Either<Failures,List<ActiveFeaturedModel>>> getActiveFeatured(NoParams params) async{
		
		throw UnimplementedError();
	}
}
