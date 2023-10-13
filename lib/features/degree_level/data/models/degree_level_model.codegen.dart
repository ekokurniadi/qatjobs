import "package:freezed_annotation/freezed_annotation.dart";

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
