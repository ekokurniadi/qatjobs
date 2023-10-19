import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart';
import 'package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart';
import 'package:qatjobs/features/jobs_skill/domain/usecases/get_jobs_skill_usecase.dart';

part 'job_skill_event.dart';
part 'job_skill_state.dart';
part 'job_skill_bloc.freezed.dart';

@injectable
class JobSkillBloc extends Bloc<JobSkillEvent, JobSkillState> {
  final GetJobsSkillUseCase _getJobSkillUseCase;
  JobSkillBloc(
    this._getJobSkillUseCase,
  ) : super(JobSkillState.initial()) {
    on<_Started>(
      (event, emit) async {
        emit(state.copyWith(status: JobSkillStatus.loading));
        final result = await _getJobSkillUseCase(NoParams());

        result.fold(
          (l) => emit(
            state.copyWith(
              status: JobSkillStatus.failure,
              message: l.errorMessage,
            ),
          ),
          (r) => emit(
            state.copyWith(
              status: JobSkillStatus.complete,
              skills: List<JobsSkillEntity>.from(
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
