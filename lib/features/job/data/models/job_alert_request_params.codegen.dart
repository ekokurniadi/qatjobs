import 'package:freezed_annotation/freezed_annotation.dart';


part "job_alert_request_params.codegen.freezed.dart";
part "job_alert_request_params.codegen.g.dart";

@freezed
class JobAlertRequestParams with _$JobAlertRequestParams {
  const factory JobAlertRequestParams({
    required int jobTypes,
    required List<int> jobAlerts,
  }) = _JobAlertRequestParams;

  factory JobAlertRequestParams.fromJson(Map<String, dynamic> json) =>
      _$JobAlertRequestParamsFromJson(json);
}
