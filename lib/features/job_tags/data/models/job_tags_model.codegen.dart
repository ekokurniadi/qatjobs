import "package:freezed_annotation/freezed_annotation.dart";

part "job_tags_model.codegen.freezed.dart";
part "job_tags_model.codegen.g.dart";

@freezed
class JobsTag with _$JobsTag {
  const factory JobsTag({
    required int id,
    required String name,
    required String description,
  }) = _JobsTag;

  factory JobsTag.fromJson(Map<String, dynamic> json) =>
      _$JobsTagFromJson(json);
}
