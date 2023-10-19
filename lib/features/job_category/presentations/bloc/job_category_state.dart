part of 'job_category_bloc.dart';

enum JobCategoryStatus { initial, loading, complete, failure }

@freezed
class JobCategoryState with _$JobCategoryState {
  const factory JobCategoryState({
    required JobCategoryStatus status,
    required String message,
    required List<JobCategoryEntity> categories,
  }) = _JobCategoryState;

  factory JobCategoryState.initial() => const JobCategoryState(
        status: JobCategoryStatus.initial,
        categories: [],
        message: '',
      );
}
