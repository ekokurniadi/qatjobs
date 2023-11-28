import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/features/slots/data/models/slots_model.codegen.dart';
import 'package:qatjobs/features/slots/domain/usecases/cancel_slot_usecase.dart';
import 'package:qatjobs/features/slots/domain/usecases/create_slot_usecase.dart';
import 'package:qatjobs/features/slots/domain/usecases/get_slots_usecase.dart';

part 'slots_state.dart';
part 'slots_cubit.freezed.dart';

@injectable
class SlotsCubit extends Cubit<SlotsState> {
  final GetSlotsUseCase _getSlotsUseCase;
  final CreateSlotsUseCase _createSlotsUseCase;
  final CancelSlotsUseCase _cancelSlotsUseCase;
  SlotsCubit(
    this._getSlotsUseCase,
    this._createSlotsUseCase,
    this._cancelSlotsUseCase,
  ) : super(SlotsState.initial());

  Future<void> getSlot(int id) async {
    emit(state.copyWith(
      status: SlotStatus.loading,
      slots: none(),
    ));
    final result = await _getSlotsUseCase(id);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: SlotStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: SlotStatus.complete,
          slots: optionOf(result),
        ),
      ),
    );
  }

  Future<void> createSlot(SlotRequestParams params) async {
    emit(state.copyWith(
      status: SlotStatus.loading,
      slots: none(),
    ));
    final result = await _createSlotsUseCase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: SlotStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: SlotStatus.created, message: 'Slot Successfully created'),
      ),
    );
  }

  Future<void> cancelSLot(CancelSlotRequestParams params) async {
    emit(state.copyWith(
      status: SlotStatus.loading,
      slots: none(),
    ));
    final result = await _cancelSlotsUseCase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: SlotStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: SlotStatus.created,
          message: 'Cancel Slot Successfully',
        ),
      ),
    );
  }
}
