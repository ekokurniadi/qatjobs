part of 'career_level_bloc.dart';

enum CareerLevelStatus { initial, loading, complete, failure }

@freezed
class CareerLevelState with _$CareerLevelState {
  const factory CareerLevelState({
    required CareerLevelStatus status,
    required String message,
    required List<CareerLevelEntity> careerLevels,
  }) = _CareerLevelState;

  factory CareerLevelState.initial() => const CareerLevelState(
        status: CareerLevelStatus.initial,
        careerLevels: [],
        message: '',
      );
}
