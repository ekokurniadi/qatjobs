part of 'job_stages_cubit.dart';

enum JobStagesStatus {
  initial,
  loading,
  complete,
  failure,
  added,
  updated,
  deleted
}

@freezed
class JobStagesState with _$JobStagesState {
  const factory JobStagesState({
    required JobStagesStatus status,
    required List<JobStagesModel> stages,
    required String message,
  }) = _JobStagesState;

  factory JobStagesState.initial() => const JobStagesState(
        stages: [],
        status: JobStagesStatus.initial,
        message: '',
      );
}
