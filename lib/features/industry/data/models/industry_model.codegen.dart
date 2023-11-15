import "package:freezed_annotation/freezed_annotation.dart";

part "industry_model.codegen.freezed.dart";
part "industry_model.codegen.g.dart";

@freezed
class IndustryModel with _$IndustryModel {
  const factory IndustryModel({
    required int id,
    required String name,
    required String description,
  }) = _IndustryModel;

  factory IndustryModel.fromJson(Map<String, dynamic> json) =>
      _$IndustryModelFromJson(json);
}
