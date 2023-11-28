import "package:dartz/dartz.dart";
import "package:equatable/equatable.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/slots/domain/repositories/slots_repository.dart";

@injectable
class CreateSlotsUseCase implements UseCase<bool, SlotRequestParams> {
  final SlotsRepository _slotsRepository;

  CreateSlotsUseCase({
    required SlotsRepository slotsRepository,
  }) : _slotsRepository = slotsRepository;

  @override
  Future<Either<Failures, bool>> call(SlotRequestParams params) async {
    return await _slotsRepository.createSlot(params);
  }
}

class SlotRequestParams extends Equatable {
  final int applicationsId;
  final String date;
  final String time;
  final String? notes;

  const SlotRequestParams({
    required this.applicationsId,
    required this.date,
    required this.time,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'time': time,
        'notes': notes,
      };

  @override
  List<Object?> get props => [
        date,
        time,
        notes,
        applicationsId,
      ];
}
