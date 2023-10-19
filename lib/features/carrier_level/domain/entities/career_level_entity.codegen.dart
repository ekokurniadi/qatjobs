import "package:freezed_annotation/freezed_annotation.dart";

part "career_level_entity.codegen.freezed.dart";
part "career_level_entity.codegen.g.dart";

@freezed
class CareerLevelEntity with _$CareerLevelEntity {
  const factory CareerLevelEntity({
    required int id,
    required String levelName,
  }) = _CareerLevelEntity;

  factory CareerLevelEntity.fromJson(Map<String, dynamic> json) =>
      _$CareerLevelEntityFromJson(json);
}
