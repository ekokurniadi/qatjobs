import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/functional_area/domain/entities/functional_area_entity.codegen.dart";

part "functional_area_model.codegen.freezed.dart";
part "functional_area_model.codegen.g.dart";

@freezed
class FunctionalAreaModel with _$FunctionalAreaModel {
  const factory FunctionalAreaModel({
    required int id,
    required String name,
  }) = _FunctionalAreaModel;

  factory FunctionalAreaModel.fromJson(Map<String, dynamic> json) =>
      _$FunctionalAreaModelFromJson(json);
}

extension FunctionalAreaModelX on FunctionalAreaModel {
  FunctionalAreaEntity toDomain() => FunctionalAreaEntity(
        id: id,
        name: name,
      );
}
