import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/job/data/models/applied_job_model.codegen.dart';
import 'package:qatjobs/features/job/data/models/favorite_job_model.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_alert_request_params.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_alerts_model.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_filter.codegen.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/job/domain/usecases/add_job_alert_usecase.dart';
import 'package:qatjobs/features/job/domain/usecases/delete_favorite_job_usecase.dart';
import 'package:qatjobs/features/job/domain/usecases/get_a_job_usecase.dart';
import 'package:qatjobs/features/job/domain/usecases/get_applied_job_usecase.dart';
import 'package:qatjobs/features/job/domain/usecases/get_favorite_job_usecase.dart';
import 'package:qatjobs/features/job/domain/usecases/get_job_alert_usecase.dart';
import 'package:qatjobs/features/job/domain/usecases/save_to_favorite_job_usecase.dart';

part 'jobs_event.dart';
part 'jobs_state.dart';
part 'jobs_bloc.freezed.dart';

@injectable
class JobsBloc extends Bloc<JobsEvent, JobsState> {
  final GetAJobUseCase _getAJobUseCase;
  final AddJobAlertUseCase _addJobAlertUseCase;
  final DeleteFavoriteJobUseCase _deleteFavoriteJobUseCase;
  final GetAppliedJobUseCase _getAppliedJobUseCase;
  final GetFavoriteJobUseCase _getFavoriteJobUseCase;
  final GetJobAlertUseCase _getJobAlertUseCase;
  final SaveToFavoriteJobUseCase _saveToFavoriteJobUseCase;
  JobsBloc(
    this._getAJobUseCase,
    this._addJobAlertUseCase,
    this._deleteFavoriteJobUseCase,
    this._getAppliedJobUseCase,
    this._getFavoriteJobUseCase,
    this._saveToFavoriteJobUseCase,
    this._getJobAlertUseCase,
  ) : super(JobsState.initial()) {
    on<_GetJobsEvent>(_getJobs);
    on<_GetFavoriteJobsEvent>(_getFavoriteJobs);
    on<_SaveFavoriteJobEvent>(_saveFavoriteJobs);
    on<_DeleteFavoriteJobEvent>(_deleteFavoriteJobs);
    on<_GetAppliedJobEvent>(_getAppliedJobs);
    on<_GetJobAlertEvent>(_getJobsAlert);
    on<_AddJobAlertEvent>(_addJobsAlert);
  }

  FutureOr<void> _getFavoriteJobs(
    _GetFavoriteJobsEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(state.copyWith(status: JobStatus.loading));
    final result = await _getFavoriteJobUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: JobStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStatus.getFavJob,
          favoriteJobs: r,
        ),
      ),
    );
  }

  FutureOr<void> _saveFavoriteJobs(
    _SaveFavoriteJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(state.copyWith(status: JobStatus.loading));
    final result = await _saveToFavoriteJobUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: JobStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStatus.insertFavJob,
          message: 'Save Favorite Job Successfuly',
        ),
      ),
    );
  }

  FutureOr<void> _deleteFavoriteJobs(
    _DeleteFavoriteJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(state.copyWith(status: JobStatus.loading));
    final result = await _deleteFavoriteJobUseCase(event.id);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: JobStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: JobStatus.deleted,
            message: 'Delete Favorite Job Successfuly'),
      ),
    );
  }

  FutureOr<void> _getAppliedJobs(
    _GetAppliedJobEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(state.copyWith(status: JobStatus.loading));
    final result = await _getAppliedJobUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: JobStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStatus.getAppliedJob,
          appliedJobs: r,
        ),
      ),
    );
  }

  FutureOr<void> _getJobsAlert(
    _GetJobAlertEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(state.copyWith(status: JobStatus.loading));
    final result = await _getJobAlertUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: JobStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStatus.getJobAlert,
          jobAlerts: r,
        ),
      ),
    );
  }

  FutureOr<void> _addJobsAlert(
    _AddJobAlertEvent event,
    Emitter<JobsState> emit,
  ) async {
    emit(state.copyWith(status: JobStatus.loading));
    final result = await _addJobAlertUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          message: l.errorMessage,
          status: JobStatus.failure,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStatus.insertJobAlert,
          message: 'Save Job Alert Successfuly',
        ),
      ),
    );
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
