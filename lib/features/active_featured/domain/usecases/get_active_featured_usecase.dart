import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/active_featured/domain/repositories/active_featured_repository.dart";
import "package:qatjobs/features/active_featured/data/models/active_featured_model.codegen.dart";

class GetActiveFeaturedUseCase implements UseCase<List<ActiveFeaturedModel>,NoParams>{
	final ActiveFeaturedRepository _activeFeaturedRepository;

	GetActiveFeaturedUseCase({
		required ActiveFeaturedRepository activeFeaturedRepository,
}):_activeFeaturedRepository =activeFeaturedRepository;

	@override
	Future<Either<Failures,List<ActiveFeaturedModel>>> call(NoParams params) async{
		return await _activeFeaturedRepository.getActiveFeatured(params);
	}
}
