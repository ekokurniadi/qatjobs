import "package:freezed_annotation/freezed_annotation.dart";

part "slots_model.codegen.freezed.dart";
part "slots_model.codegen.g.dart";

@freezed
class SlotsModel with _$SlotsModel {
  const factory SlotsModel({
    @JsonKey(name: 'jobStage') required Map<String, dynamic> jobStages,
    @JsonKey(name: 'lastStage') required LastStageModel lastStage,
    @JsonKey(name: 'slots') required List<LastStageModel> jobSchedules,
    @JsonKey(name: 'isSelectedRejectedSlot')
    required int isSelectedRejectedSlot,
    @JsonKey(name: 'isStageMatch') required bool isStageMatch,
  }) = _SlotsModel;

  factory SlotsModel.fromJson(Map<String, dynamic> json) =>
      _$SlotsModelFromJson(json);
}

@freezed
class LastStageModel with _$LastStageModel {
  factory LastStageModel({
    required int id,
    required int jobApplicationId,
    required int stageId,
    required String time,
    required String date,
    String? notes,
    required int status,
    required int batch,
    String? rejectedSlotNotes,
    String? employerCancelSlotNotes,
  }) = _LastStageModel;

  factory LastStageModel.fromJson(Map<String, dynamic> json) =>
      _$LastStageModelFromJson(json);
}
