part of 'degree_level_bloc.dart';

enum DegreeLevelStatus { initial, loading, complete, failure }

@freezed
class DegreeLevelState with _$DegreeLevelState {
  const factory DegreeLevelState({
    required DegreeLevelStatus status,
    required String message,
    required List<DegreeLevelEntity> degreeLevels,
  }) = _DegreeLevelState;

  factory DegreeLevelState.initial() => const DegreeLevelState(
        status: DegreeLevelStatus.initial,
        degreeLevels: [],
        message: '',
      );
}
