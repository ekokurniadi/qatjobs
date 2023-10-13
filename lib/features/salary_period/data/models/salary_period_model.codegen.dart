import "package:freezed_annotation/freezed_annotation.dart";

part "salary_period_model.codegen.freezed.dart";
part "salary_period_model.codegen.g.dart";

@freezed
class SalaryPeriod with _$SalaryPeriod {
  const factory SalaryPeriod({
    required int id,
    required String period,
    required String description,
  }) = _SalaryPeriod;

  factory SalaryPeriod.fromJson(Map<String, dynamic> json) =>
      _$SalaryPeriodFromJson(json);
}
