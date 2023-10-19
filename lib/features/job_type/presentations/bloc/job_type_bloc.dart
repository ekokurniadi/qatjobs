import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/job_type/data/models/jobs_type_model.codegen.dart';
import 'package:qatjobs/features/job_type/domain/entities/jobs_type_entity.codegen.dart';
import 'package:qatjobs/features/job_type/domain/usecases/get_job_type_usecase.dart';


part 'job_type_event.dart';
part 'job_type_state.dart';
part 'job_type_bloc.freezed.dart';

@injectable
class JobTypeBloc extends Bloc<JobTypeEvent, JobTypeState> {
  final GetJobTypeUseCase _getJobTypeUseCase;
  JobTypeBloc(
    this._getJobTypeUseCase,
  ) : super(JobTypeState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: JobTypeStatus.loading));
        final result = await _getJobTypeUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: JobTypeStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: JobTypeStatus.complete,
              types: List<JobTypeEntity>.from(
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
