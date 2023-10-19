import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart";
import "package:qatjobs/features/carrier_level/domain/repositories/career_level_repository.dart";

@injectable
class GetCareerLevelUseCase
    implements UseCase<List<CareerLevelModel>, NoParams> {
  final CareerLevelRepository _careerLevelRepository;

  GetCareerLevelUseCase({
    required CareerLevelRepository careerLevelRepository,
  }) : _careerLevelRepository = careerLevelRepository;

  @override
  Future<Either<Failures, List<CareerLevelModel>>> call(NoParams params) async {
    return await _careerLevelRepository.getCareerLevel(params);
  }
}
