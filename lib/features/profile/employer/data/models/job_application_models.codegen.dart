import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/job/data/models/job_model.codegen.dart';
import 'package:qatjobs/features/job_stages/data/models/job_stages_model.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';

part "job_application_models.codegen.freezed.dart";
part "job_application_models.codegen.g.dart";

@unfreezed
class JobApplicationModel with _$JobApplicationModel {
  factory JobApplicationModel({
    required int id,
    required int jobId,
    required int candidateId,
    required int expectedSalary,
    String? notes,
    required int status,
    required String createdAt,
    required String resumeUrl,
    required JobModel job,
    JobStagesModel? jobStage,
    required ProfileCandidateModels candidate,
  }) = _JobApplicationModel;

  factory JobApplicationModel.fromJson(Map<String, dynamic> json) =>
      _$JobApplicationModelFromJson(json);
}
