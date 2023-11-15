import "package:freezed_annotation/freezed_annotation.dart";

part "employer_type_model.codegen.freezed.dart";
part "employer_type_model.codegen.g.dart";

@freezed
class EmployerTypeModel with _$EmployerTypeModel {
  const factory EmployerTypeModel({
    required int id,
    required String name,
    required String description,
  }) = _EmployerTypeModel;

  factory EmployerTypeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployerTypeModelFromJson(json);
}
