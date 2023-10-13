import "package:freezed_annotation/freezed_annotation.dart";

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
