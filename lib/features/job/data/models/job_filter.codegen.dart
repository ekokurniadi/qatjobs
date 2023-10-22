import 'package:freezed_annotation/freezed_annotation.dart';

part "job_filter.codegen.freezed.dart";
part "job_filter.codegen.g.dart";

@unfreezed
class JobFilterModel with _$JobFilterModel {
  @JsonSerializable(includeIfNull: false)
  factory JobFilterModel({
    String? title,
    String? location,
    int? jobTypeId,
    int? jobCategoryId,
    int? salaryFrom,
    int? salaryTo,
    int? careerLevelId,
    int? functionalAreaId,
    int? skillId,
    int? companyId,
    int? experience,
    @JsonKey(name: 'perPage') @Default(10) int? perPage,
    @Default(1) int? page,
  }) = _JobFilterModel;

  factory JobFilterModel.fromJson(Map<String, dynamic> json) =>
      _$JobFilterModelFromJson(json);
}
