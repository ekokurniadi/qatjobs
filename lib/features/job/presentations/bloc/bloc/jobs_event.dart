part of 'jobs_bloc.dart';

@freezed
class JobsEvent with _$JobsEvent {
  const factory JobsEvent.getJobs(
    JobFilterModel filter,
    bool isFiltered,
  ) = _GetJobsEvent;
}
