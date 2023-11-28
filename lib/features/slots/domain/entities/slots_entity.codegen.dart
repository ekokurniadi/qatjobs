import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart";

part "slots_entity.codegen.freezed.dart";
part "slots_entity.codegen.g.dart";

@freezed
class SlotsEntity with _$SlotsEntity {
  const factory SlotsEntity({
    required List<JobStagesModel> jobStages,
    required Map<String, dynamic> lastStage,
    required int isSelectedRejectedSlot,
    required bool isStageMatch,
  }) = _SlotsEntity;

  factory SlotsEntity.fromJson(Map<String, dynamic> json) =>
      _$SlotsEntityFromJson(json);
}
