import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';

part "applied_job_model.codegen.freezed.dart";
part "applied_job_model.codegen.g.dart";

@freezed
class AppliedJobModel with _$AppliedJobModel {
  factory AppliedJobModel({
    required int id,
    required int resumeId,
    int? expectedSalary,
    String? notes,
    required int status,
    required String resumeUrl,
    required JobModel job,
    JobStage? jobStage,
  }) = _AppliedJobModel;

  factory AppliedJobModel.fromJson(Map<String, dynamic> json) =>
      _$AppliedJobModelFromJson(json);
}

@freezed
class JobStage with _$JobStage {
  factory JobStage({
    required int id,
    required String name,
    required String description,
    required int companyId,
  }) = _JobStage;

  factory JobStage.fromJson(Map<String, dynamic> json) =>
      _$JobStageFromJson(json);
}
