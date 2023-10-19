part of 'functional_area_bloc.dart';

enum FunctionalAreaStatus { initial, loading, complete, failure }

@freezed
class FunctionalAreaState with _$FunctionalAreaState {
  const factory FunctionalAreaState({
    required FunctionalAreaStatus status,
    required String message,
    required List<FunctionalAreaEntity> functionalAreas,
  }) = _FunctionalAreaState;

  factory FunctionalAreaState.initial() => const FunctionalAreaState(
        status: FunctionalAreaStatus.initial,
        functionalAreas: [],
        message: '',
      );
}
