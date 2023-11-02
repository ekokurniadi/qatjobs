import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/resume_entity.codegen.dart';

part "resume_models.codegen.freezed.dart";
part "resume_models.codegen.g.dart";

@freezed
class ResumeModels with _$ResumeModels {
  const factory ResumeModels({
    required int id,
    required String name,
    required Map<String, dynamic> customProperties,
    required String originalUrl,
    required String mimeType,
    required String size,
  }) = _ResumeModels;

  factory ResumeModels.fromJson(Map<String, dynamic> json) =>
      _$ResumeModelsFromJson(json);
}

extension ResumeModelX on ResumeModels {
  ResumeEntity toDomain() => ResumeEntity(
        id: id,
        name: name,
        customProperties: customProperties,
        originalUrl: originalUrl,
        mimeType: mimeType,
        size: size,
      );
}
