import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/slots/data/models/candidate_slot_model.dart";
import "package:qatjobs/features/slots/domain/repositories/slots_repository.dart";

@injectable
class GetCandidateSlotsUseCase implements UseCase<CandidateSlots, int> {
  final SlotsRepository _slotsRepository;

  GetCandidateSlotsUseCase({
    required SlotsRepository slotsRepository,
  }) : _slotsRepository = slotsRepository;

  @override
  Future<Either<Failures, CandidateSlots>> call(int params) async {
    return await _slotsRepository.getCandidateSlots(params);
  }
}
