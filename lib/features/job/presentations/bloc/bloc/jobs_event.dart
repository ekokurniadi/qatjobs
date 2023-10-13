part of 'jobs_bloc.dart';

@freezed
class JobsEvent with _$JobsEvent {
  const factory JobsEvent.getJobs() = _GetJobsEvent;
}