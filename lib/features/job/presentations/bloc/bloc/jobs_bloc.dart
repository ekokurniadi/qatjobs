import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/job/data/models/job_filter.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/job/domain/usecases/get_a_job_usecase.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';
part 'jobs_bloc.freezed.dart';

@injectable
class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final GetAJobUseCase _getAJobUseCase;
  JobsBloc(
    this._getAJobUseCase,
  ) : super(JobsState.initial()) {
    on<_GetJobsEvent>(_getJobs);
  }

  FutureOr<void> _getJobs(_GetJobsEvent event, Emitter<JobsState> emit) async {
    emit(state.copyWith(status: JobStatus.loading));
    final result = await _getAJobUseCase(event.filter);
    if (event.isFiltered) {
      state.jobs.clear();
    }
    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: JobStatus.failure,
        ),
      ),
      (r) => r.isEmpty
          ? event.isFiltered
              ? emit(
                  state.copyWith(
                    hasMaxReached: true,
                    jobFilter: event.filter,
                    status: JobStatus.success,
                    isFilterActive: event.isFiltered,
                    jobs: [],
                  ),
                )
              : emit(
                  state.copyWith(
                    hasMaxReached: true,
                    jobFilter: event.filter,
                    status: JobStatus.success,
                    isFilterActive: event.isFiltered,
                  ),
                )
          : emit(
              state.copyWith(
                status: JobStatus.success,
                jobs: (state.jobs + r).toSet().toList(),
                currentPage: event.filter.page ?? 1,
                jobFilter: event.filter,
                isFilterActive: event.isFiltered,
              ),
            ),
    );
  }

  bool isJobFilterNotEmpty(JobFilterModel jobModel) {
    return jobModel.careerLevelId != null ||
        jobModel.companyId != null ||
        jobModel.experience != null ||
        jobModel.jobCategoryId != null ||
        jobModel.jobTypeId != null ||
        jobModel.functionalAreaId != null ||
        jobModel.location != null ||
        jobModel.salaryTo != null ||
        jobModel.salaryFrom != null ||
        jobModel.skillId != null;
  }
}
