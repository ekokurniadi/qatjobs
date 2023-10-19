import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/job_type/domain/entities/jobs_type_entity.codegen.dart";
part "jobs_type_model.codegen.freezed.dart";
part "jobs_type_model.codegen.g.dart";

@freezed
class JobTypeModel with _$JobTypeModel {
  const factory JobTypeModel({
    required int id,
    required String name,
    required String description,
  }) = _JobTypeModel;

  factory JobTypeModel.fromJson(Map<String, dynamic> json) =>
      _$JobTypeModelFromJson(json);
}

extension JobTypeModelX on JobTypeModel {
  JobTypeEntity toDomain() => JobTypeEntity(
        id: id,
        name: name,
        description: description,
      );
}
