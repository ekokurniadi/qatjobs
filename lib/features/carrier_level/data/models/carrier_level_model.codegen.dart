import "package:freezed_annotation/freezed_annotation.dart";

part "carrier_level_model.codegen.freezed.dart";
part "carrier_level_model.codegen.g.dart";

@freezed
class CarrierLevelModel with _$CarrierLevelModel {
  const factory CarrierLevelModel({
    required int id,
    required String levelName,
  }) = _CarrierLevelModel;

  factory CarrierLevelModel.fromJson(Map<String, dynamic> json) =>
      _$CarrierLevelModelFromJson(json);
}
