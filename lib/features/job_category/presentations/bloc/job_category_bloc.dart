import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart';
import 'package:qatjobs/features/job_category/domain/entities/job_category_entity.codegen.dart';
import 'package:qatjobs/features/job_category/domain/usecases/get_job_category_usecase.dart';

part 'job_category_event.dart';
part 'job_category_state.dart';
part 'job_category_bloc.freezed.dart';

@injectable
class JobCategoryBloc extends Bloc<JobCategoryEvent, JobCategoryState> {
  final GetJobCategoryUseCase _getJobCategoryUseCase;
  JobCategoryBloc(
    this._getJobCategoryUseCase,
  ) : super(JobCategoryState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: JobCategoryStatus.loading));
        final result = await _getJobCategoryUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: JobCategoryStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: JobCategoryStatus.complete,
              categories: List<JobCategoryEntity>.from(
                r.map(
                  (e) => e.toDomain(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
