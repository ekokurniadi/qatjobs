import 'package:freezed_annotation/freezed_annotation.dart';

part "resume_entity.codegen.freezed.dart";
part "resume_entity.codegen.g.dart";

@freezed
class ResumeEntity with _$ResumeEntity {
  const factory ResumeEntity({
    required int id,
    required String name,
    required Map<String, dynamic> customProperties,
    required String originalUrl,
  }) = _ResumeEntity;

  factory ResumeEntity.fromJson(Map<String, dynamic> json) =>
      _$ResumeEntityFromJson(json);
}
