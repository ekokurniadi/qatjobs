import 'package:freezed_annotation/freezed_annotation.dart';

part "job_request_params.codegen.freezed.dart";
part "job_request_params.codegen.g.dart";

@unfreezed
class JobRequestParams with _$JobRequestParams {
  @JsonSerializable(includeIfNull: false)
  factory JobRequestParams({
    String? q,
    String? featured,
    String? status,
    @JsonKey(name: 'perPage') @Default(10) int? perPage,
    @Default(1) int? page,
  }) = _JobRequestParams;

  factory JobRequestParams.fromJson(Map<String, dynamic> json) =>
      _$JobRequestParamsFromJson(json);
}
