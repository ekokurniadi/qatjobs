import "package:freezed_annotation/freezed_annotation.dart";
import 'package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart';
part "jobs_skill_model.codegen.freezed.dart";
part "jobs_skill_model.codegen.g.dart";

@freezed
class JobsSkillModel with _$JobsSkillModel {
  const factory JobsSkillModel({
    required int id,
    required String name,
    required String description,
  }) = _JobsSkillModel;

  factory JobsSkillModel.fromJson(Map<String, dynamic> json) =>
      _$JobsSkillModelFromJson(json);
}

extension JobsSkillModelX on JobsSkillModel {
  JobsSkillEntity toDomain() => JobsSkillEntity(
        id: id,
        name: name,
        description: description,
      );
}
