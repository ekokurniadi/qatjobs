part of 'slots_cubit.dart';

enum SlotStatus { initial, loading, complete, failure, created }

@freezed
class SlotsState with _$SlotsState {
  const factory SlotsState({
    required SlotStatus status,
    required Option<Either<Failures, SlotsModel>> slots,
    required String message,
  }) = _SlotsState;

  factory SlotsState.initial() => SlotsState(
        status: SlotStatus.initial,
        slots: none(),
        message: '',
      );
}
