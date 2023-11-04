import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/degree_level/domain/entities/degree_level_entity.codegen.dart";

part "degree_level_model.codegen.freezed.dart";
part "degree_level_model.codegen.g.dart";

@freezed
class DegreeLevelModel with _$DegreeLevelModel {
  const factory DegreeLevelModel({
    required int id,
    required String name,
  }) = _DegreeLevelModel;

  factory DegreeLevelModel.fromJson(Map<String, dynamic> json) =>
      _$DegreeLevelModelFromJson(json);
}

extension DegreeLevelModelX on DegreeLevelModel {
  DegreeLevelEntity toDomain() => DegreeLevelEntity(id: id, name: name);
}
