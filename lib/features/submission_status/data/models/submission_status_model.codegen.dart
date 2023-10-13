import "package:freezed_annotation/freezed_annotation.dart";

part "submission_status_model.codegen.freezed.dart";
part "submission_status_model.codegen.g.dart";

@freezed
class SubmissionStatus with _$SubmissionStatus {
  const factory SubmissionStatus({
    required int id,
    required String statusName,
  }) = _SubmissionStatus;

  factory SubmissionStatus.fromJson(Map<String, dynamic> json) =>
      _$SubmissionStatusFromJson(json);
}
