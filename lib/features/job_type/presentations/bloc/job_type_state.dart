part of 'job_type_bloc.dart';

enum JobTypeStatus { initial, loading, complete, failure }

@freezed
class JobTypeState with _$JobTypeState {
  const factory JobTypeState({
    required JobTypeStatus status,
    required String message,
    required List<JobTypeEntity> types,
  }) = _JobTypeState;

  factory JobTypeState.initial() => const JobTypeState(
        status: JobTypeStatus.initial,
        types: [],
        message: '',
      );
}
