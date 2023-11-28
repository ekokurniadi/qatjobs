import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/features/slots/data/models/slots_model.codegen.dart";
import "package:qatjobs/features/slots/domain/usecases/cancel_slot_usecase.dart";
import "package:qatjobs/features/slots/domain/usecases/create_slot_usecase.dart";

abstract class SlotsRemoteDataSource {
  Future<Either<Failures, SlotsModel>> getSlots(int params);
  Future<Either<Failures, bool>> createSlot(SlotRequestParams params);
  Future<Either<Failures, bool>> cancelSlot(CancelSlotRequestParams params);
}
