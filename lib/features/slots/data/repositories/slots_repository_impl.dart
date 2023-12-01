import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/features/slots/data/models/candidate_slot_model.dart";
import "package:qatjobs/features/slots/domain/repositories/slots_repository.dart";
import "package:qatjobs/features/slots/data/datasources/remote/slots_remote_datasource.dart";
import "package:qatjobs/features/slots/data/models/slots_model.codegen.dart";
import "package:qatjobs/features/slots/domain/usecases/cancel_slot_usecase.dart";
import "package:qatjobs/features/slots/domain/usecases/create_slot_usecase.dart";

@LazySingleton(as: SlotsRepository)
class SlotsRepositoryImpl implements SlotsRepository {
  final SlotsRemoteDataSource _slotsRemoteDataSource;

  const SlotsRepositoryImpl({
    required SlotsRemoteDataSource slotsRemoteDataSource,
  }) : _slotsRemoteDataSource = slotsRemoteDataSource;

  @override
  Future<Either<Failures, SlotsModel>> getSlots(int params) async {
    return await _slotsRemoteDataSource.getSlots(params);
  }

  @override
  Future<Either<Failures, bool>> createSlot(
      List<SlotRequestParams> params) async {
    return await _slotsRemoteDataSource.createSlot(params);
  }

  @override
  Future<Either<Failures, bool>> cancelSlot(
      CancelSlotRequestParams params) async {
    return await _slotsRemoteDataSource.cancelSlot(params);
  }

  @override
  Future<Either<Failures, CandidateSlots>> getCandidateSlots(int params) async {
    return await _slotsRemoteDataSource.getCandidateSlots(params);
  }
}
