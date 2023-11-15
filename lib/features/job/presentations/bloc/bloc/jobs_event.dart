part of 'jobs_bloc.dart';

@freezed
class JobsEvent with _$JobsEvent {
  const factory JobsEvent.getJobs(
    JobFilterModel filter,
    bool isFiltered,
  ) = _GetJobsEvent;
  const factory JobsEvent.getFavoriteJob() = _GetFavoriteJobsEvent;
  const factory JobsEvent.saveFavoriteJob(FavoriteJobRequestParams params) =
      _SaveFavoriteJobEvent;
  const factory JobsEvent.deleteFavoriteJob(int id) = _DeleteFavoriteJobEvent;
  const factory JobsEvent.getAppliedJob() = _GetAppliedJobEvent;
  const factory JobsEvent.getJobAlert() = _GetJobAlertEvent;
  const factory JobsEvent.addJobAlert(JobAlertRequestParams params) =
      _AddJobAlertEvent;
  const factory JobsEvent.applyJob(ApplyJobRequestParams params) =
      _ApplyJobAlertEvent;
  const factory JobsEvent.getFilteredJobs(
    JobFilterModel filter,
  ) = _GetFilteredJobsEvent;
  const factory JobsEvent.emailToFriend(
    EmailToFriendRequestParams filter,
  ) = _EmailToFriendEvent;
}
