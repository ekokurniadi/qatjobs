import 'package:freezed_annotation/freezed_annotation.dart';

part "resume_models.codegen.freezed.dart";
part "resume_models.codegen.g.dart";

@freezed
class ResumeModels with _$ResumeModels {
  const factory ResumeModels({
    required int id,
    required String name,
    required Map<String, dynamic> customProperties,
    required String originalUrl,
  }) = _ResumeModels;

  factory ResumeModels.fromJson(Map<String, dynamic> json) =>
      _$ResumeModelsFromJson(json);
}
