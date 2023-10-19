import "package:freezed_annotation/freezed_annotation.dart";

part "jobs_type_entity.codegen.freezed.dart";

@freezed
class JobTypeEntity with _$JobTypeEntity {
  const factory JobTypeEntity({
    required int id,
    required String name,
    required String description,
  }) = _JobTypeEntity;
}
