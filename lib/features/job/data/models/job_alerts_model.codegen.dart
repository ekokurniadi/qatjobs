import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/job_type/data/models/jobs_type_model.codegen.dart";
import "package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart";

part "job_alerts_model.codegen.freezed.dart";
part "job_alerts_model.codegen.g.dart";

@freezed
class JobAlertsModel with _$JobAlertsModel {
  const factory JobAlertsModel({
    @JsonKey(name: 'jobTypes') required List<JobTypeModel> jobTypes,
    @JsonKey(name: 'jobAlerts') required List<String> jobAlerts,
    required ProfileCandidateModels candidate,
  }) = _JobAlertsModel;

  factory JobAlertsModel.fromJson(Map<String, dynamic> json) =>
      _$JobAlertsModelFromJson(json);
}
