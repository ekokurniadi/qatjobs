import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/active_featured/data/models/active_featured_model.codegen.dart";

abstract class ActiveFeaturedRepository {
	Future<Either<Failures,List<ActiveFeaturedModel>>> getActiveFeatured(NoParams params);
}
