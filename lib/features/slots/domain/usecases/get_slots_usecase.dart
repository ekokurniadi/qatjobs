import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/slots/domain/repositories/slots_repository.dart";
import "package:qatjobs/features/slots/data/models/slots_model.codegen.dart";

@injectable
class GetSlotsUseCase implements UseCase<SlotsModel, int> {
  final SlotsRepository _slotsRepository;

  GetSlotsUseCase({
    required SlotsRepository slotsRepository,
  }) : _slotsRepository = slotsRepository;

  @override
  Future<Either<Failures, SlotsModel>> call(int params) async {
    return await _slotsRepository.getSlots(params);
  }
}
