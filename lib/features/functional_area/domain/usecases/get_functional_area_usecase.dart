import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/functional_area/domain/repositories/functional_area_repository.dart";
import "package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart";

@injectable
class GetFunctionalAreaUseCase
    implements UseCase<List<FunctionalAreaModel>, NoParams> {
  final FunctionalAreaRepository _functionalAreaRepository;

  GetFunctionalAreaUseCase({
    required FunctionalAreaRepository functionalAreaRepository,
  }) : _functionalAreaRepository = functionalAreaRepository;

  @override
  Future<Either<Failures, List<FunctionalAreaModel>>> call(
      NoParams params) async {
    return await _functionalAreaRepository.getFunctionalArea(params);
  }
}
