import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/error/failures.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/features/slots/data/models/candidate_slot_model.dart';
import 'package:qatjobs/features/slots/data/models/slots_model.codegen.dart';
import 'package:qatjobs/features/slots/domain/usecases/cancel_slot_usecase.dart';
import 'package:qatjobs/features/slots/domain/usecases/create_slot_usecase.dart';
import 'package:qatjobs/features/slots/domain/usecases/get_candidate_slot_usecase.dart';
import 'package:qatjobs/features/slots/domain/usecases/get_slots_usecase.dart';

part 'slots_state.dart';
part 'slots_cubit.freezed.dart';

@injectable
class SlotsCubit extends Cubit<SlotsState> {
  final GetSlotsUseCase _getSlotsUseCase;
  final CreateSlotsUseCase _createSlotsUseCase;
  final CancelSlotsUseCase _cancelSlotsUseCase;
  final GetCandidateSlotsUseCase _getCandidateSlotsUseCase;
  SlotsCubit(
    this._getSlotsUseCase,
    this._createSlotsUseCase,
    this._cancelSlotsUseCase,
    this._getCandidateSlotsUseCase,
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

  Future<void> createSlot(List<SlotRequestParams> params) async {
    emit(state.copyWith(
      status: SlotStatus.loading,
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

  Future<void> getCandidateSlot(int id) async {
    emit(state.copyWith(
      status: SlotStatus.loading,
      slots: none(),
    ));
    final result = await _getCandidateSlotsUseCase(id);

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
          candidateSlots: optionOf(result),
        ),
      ),
    );
  }

  Future<void> candidateChoosePreference(
    int id, {
    bool? rejectSlot,
    required String chooseSlotNotes,
    int? slotId,
  }) async {
    emit(state.copyWith(
      status: SlotStatus.loading,
    ));

    Map<String, dynamic> request = {};
    if (rejectSlot != null && rejectSlot == true) {
      request['rejectSlot'] = rejectSlot;
      request['choose_slot_notes'] = chooseSlotNotes;
    } else {
      request['slot_id'] = slotId;
      request['choose_slot_notes'] = chooseSlotNotes;
    }
    final form = FormData.fromMap(request);
    try {
      final response = await DioHelper.dio!.post(
        URLConstant.candidateJobSlots(id),
        data: form,
      );

      if (response.isOk) {
        emit(
          state.copyWith(
            message: 'Successfully',
            status: SlotStatus.created,
          ),
        );
      } else {
        emit(
          state.copyWith(
            message: response.data['message'] ?? 'Something when wrong',
            status: SlotStatus.failure,
          ),
        );
      }
    } on DioError catch (e) {
      emit(
        state.copyWith(
          message: DioHelper.formatException(e),
          status: SlotStatus.failure,
        ),
      );
    }
  }
}
