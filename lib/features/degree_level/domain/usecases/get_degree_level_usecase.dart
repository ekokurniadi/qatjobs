import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/degree_level/domain/repositories/degree_level_repository.dart";
import "package:qatjobs/features/degree_level/data/models/degree_level_model.codegen.dart";

@injectable
class GetDegreeLevelUseCase implements UseCase<List<DegreeLevelModel>,NoParams>{
	final DegreeLevelRepository _degreeLevelRepository;

	GetDegreeLevelUseCase({
		required DegreeLevelRepository degreeLevelRepository,
}):_degreeLevelRepository =degreeLevelRepository;

	@override
	Future<Either<Failures,List<DegreeLevelModel>>> call(NoParams params) async{
		return await _degreeLevelRepository.getDegreeLevel(params);
	}
}
