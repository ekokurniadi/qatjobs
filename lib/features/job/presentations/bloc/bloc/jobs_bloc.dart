import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
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
    final result = await _getAJobUseCase(NoParams());
    result.fold(
      (l) => null,
      (r) => emit(
        state.copyWith(
          status: JobStatus.success,
          jobs: r,
        ),
      ),
    );
  }
}
