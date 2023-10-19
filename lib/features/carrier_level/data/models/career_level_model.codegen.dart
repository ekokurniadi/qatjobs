import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/carrier_level/domain/entities/career_level_entity.codegen.dart";

part "career_level_model.codegen.freezed.dart";
part "career_level_model.codegen.g.dart";

@freezed
class CareerLevelModel with _$CareerLevelModel {
  const factory CareerLevelModel({
    required int id,
    required String levelName,
  }) = _CareerLevelModel;

  factory CareerLevelModel.fromJson(Map<String, dynamic> json) =>
      _$CareerLevelModelFromJson(json);
}

extension CareerLevelModelX on CareerLevelModel {
  CareerLevelEntity toDomain() => CareerLevelEntity(
        id: id,
        levelName: levelName,
      );
}
