part of 'job_category_bloc.dart';

@freezed
class JobCategoryEvent with _$JobCategoryEvent {
  const factory JobCategoryEvent.started() = _Started;
}