part of 'jobs_bloc.dart';

enum JobStatus {
  initial,
  loading,
  success,
  failure,
}

@freezed
class JobsState with _$JobsState {
  const factory JobsState({
    required JobStatus status,
    required List<JobModel> jobs,
    required String message,
  }) = _JobsState;

  factory JobsState.initial() => const JobsState(
        status: JobStatus.initial,
        jobs: [],
        message: '',
      );
}
