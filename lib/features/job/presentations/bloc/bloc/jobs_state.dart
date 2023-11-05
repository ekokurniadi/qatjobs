part of 'jobs_bloc.dart';

enum JobStatus {
  initial,
  loading,
  success,
  failure,
  insertFavJob,
  getFavJob,
  getAppliedJob,
  insertJobAlert,
  getJobAlert,
  deleted,
}

@freezed
class JobsState with _$JobsState {
  const factory JobsState({
    required JobStatus status,
    required List<JobModel> jobs,
    required List<AppliedJobModel> appliedJobs,
    required List<FavoriteJobModel> favoriteJobs,
    required JobAlertsModel jobAlerts,
    required String message,
    required bool hasMaxReached,
    required JobFilterModel jobFilter,
    required int currentPage,
    required bool isFilterActive,
  }) = _JobsState;

  factory JobsState.initial() => JobsState(
        status: JobStatus.initial,
        jobs: [],
        message: '',
        hasMaxReached: false,
        jobFilter: JobFilterModel(),
        currentPage: 0,
        isFilterActive: false,
        appliedJobs: [],
        favoriteJobs: [],
        jobAlerts: const JobAlertsModel(
          jobTypes: [],
          jobAlerts: [],
        ),
      );
}
