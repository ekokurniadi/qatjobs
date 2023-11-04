import "package:freezed_annotation/freezed_annotation.dart";

part "degree_level_entity.codegen.freezed.dart";

@freezed
class DegreeLevelEntity with _$DegreeLevelEntity {
  const factory DegreeLevelEntity({
    required int id,
    required String name,
  }) = _DegreeLevelEntity;
}
