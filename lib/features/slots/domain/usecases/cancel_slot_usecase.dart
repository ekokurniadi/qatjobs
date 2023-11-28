import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/slots/domain/repositories/slots_repository.dart";

@injectable
class CancelSlotsUseCase implements UseCase<bool, CancelSlotRequestParams> {
  final SlotsRepository _slotsRepository;

  CancelSlotsUseCase({
    required SlotsRepository slotsRepository,
  }) : _slotsRepository = slotsRepository;

  @override
  Future<Either<Failures, bool>> call(CancelSlotRequestParams params) async {
    return await _slotsRepository.cancelSlot(params);
  }
}

class CancelSlotRequestParams extends Equatable {
  final int applicationsId;
  final int slotId;

  final String notes;

  const CancelSlotRequestParams({
    required this.applicationsId,
    required this.slotId,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        notes,
        applicationsId,
        slotId,
      ];
}
