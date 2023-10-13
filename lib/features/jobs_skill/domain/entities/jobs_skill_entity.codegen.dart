import "package:freezed_annotation/freezed_annotation.dart";

part "jobs_skill_entity.codegen.freezed.dart";

@freezed
class JobsSkillEntity with _$JobsSkillEntity {
  const factory JobsSkillEntity({
    required int id,
    required String name,
    required String description,
  }) = _JobsSkillEntity;
}
