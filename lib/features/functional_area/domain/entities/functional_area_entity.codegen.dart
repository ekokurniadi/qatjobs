import "package:freezed_annotation/freezed_annotation.dart";

part "functional_area_entity.codegen.freezed.dart";
part "functional_area_entity.codegen.g.dart";

@freezed
class FunctionalAreaEntity with _$FunctionalAreaEntity {
  const factory FunctionalAreaEntity({
    required int id,
    required String name,
  }) = _FunctionalAreaEntity;

  factory FunctionalAreaEntity.fromJson(Map<String, dynamic> json) =>
      _$FunctionalAreaEntityFromJson(json);
}
