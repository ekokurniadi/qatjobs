import "package:freezed_annotation/freezed_annotation.dart";

part "job_stages_model.codegen.freezed.dart";
part "job_stages_model.codegen.g.dart";

@freezed
class JobStagesModel with _$JobStagesModel{

const factory JobStagesModel({ 
	required int id,
	required String name,
	required String description,
})=_JobStagesModel; 


factory JobStagesModel.fromJson(Map<String,dynamic>json) => _$JobStagesModelFromJson(json);

}
