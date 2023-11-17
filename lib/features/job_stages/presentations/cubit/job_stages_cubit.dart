import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart';
import 'package:qatjobs/features/job_stages/domain/usecases/add_job_stages_usecase.dart';
import 'package:qatjobs/features/job_stages/domain/usecases/delete_job_stages_usecase.dart';
import 'package:qatjobs/features/job_stages/domain/usecases/get_job_stages_usecase.dart';
import 'package:qatjobs/features/job_stages/domain/usecases/update_job_stages_usecase.dart';

part 'job_stages_state.dart';
part 'job_stages_cubit.freezed.dart';

@injectable
class JobStagesCubit extends Cubit<JobStagesState> {
  final AddJobStagesUseCase _addJobStagesUseCase;
  final UpdateJobStagesUseCase _updateJobStagesUseCase;
  final DeleteJobStagesUseCase _deleteJobStagesUseCase;
  final GetJobStagesUseCase _getJobStagesUseCase;

  JobStagesCubit(
    this._addJobStagesUseCase,
    this._updateJobStagesUseCase,
    this._deleteJobStagesUseCase,
    this._getJobStagesUseCase,
  ) : super(JobStagesState.initial());

  Future<void> add(JobStagesRequestParams params) async {
    emit(state.copyWith(status: JobStagesStatus.loading));
    final result = await _addJobStagesUseCase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: JobStagesStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStagesStatus.added,
          message: 'Job Stages Added Successfully',
        ),
      ),
    );
  }

  Future<void> update(JobStagesRequestParams params) async {
    emit(state.copyWith(status: JobStagesStatus.loading));
    final result = await _updateJobStagesUseCase(params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: JobStagesStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStagesStatus.updated,
          message: 'Job Stages Update Successfully',
        ),
      ),
    );
  }

  Future<void> delete(int id) async {
    emit(state.copyWith(status: JobStagesStatus.loading));
    final result = await _deleteJobStagesUseCase(id);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: JobStagesStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStagesStatus.deleted,
          message: 'Job Stages Deleted Successfully',
        ),
      ),
    );
  }

  Future<void> get() async {
    emit(state.copyWith(status: JobStagesStatus.loading));
    final result = await _getJobStagesUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: JobStagesStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: JobStagesStatus.complete,
          stages: r,
        ),
      ),
    );
  }
}
