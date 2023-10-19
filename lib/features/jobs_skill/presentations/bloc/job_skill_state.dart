part of 'job_skill_bloc.dart';

enum JobSkillStatus { initial, loading, complete, failure }

@freezed
class JobSkillState with _$JobSkillState {
  const factory JobSkillState({
    required JobSkillStatus status,
    required String message,
    required List<JobsSkillEntity> skills,
  }) = _JobSkillState;

  factory JobSkillState.initial() => const JobSkillState(
        status: JobSkillStatus.initial,
        skills: [],
        message: '',
      );
}
