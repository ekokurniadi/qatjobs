import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/currency/data/models/currency_model.codegen.dart";

part "plan_model.codegen.freezed.dart";
part "plan_model.codegen.g.dart";

@freezed
class PlanModel with _$PlanModel {
  const factory PlanModel({
    required int id,
    required String name,
    required int allowedJobs,
    required int amount,
    required bool isTrialPlan,
    required CurrencyModel salaryCurrency,
  }) = _PlanModel;

  factory PlanModel.fromJson(Map<String, dynamic> json) =>
      _$PlanModelFromJson(json);
}
