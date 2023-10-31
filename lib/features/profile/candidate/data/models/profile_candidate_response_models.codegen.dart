import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';


part "profile_candidate_response_models.codegen.freezed.dart";
part "profile_candidate_response_models.codegen.g.dart";

@freezed
class ProfileCandidateResponseModels with _$ProfileCandidateResponseModels {
  factory ProfileCandidateResponseModels({
    required ProfileCandidateModels candidate,
    required List<JobsSkillModel> candidateSkill,
  }) = _ProfileCandidateResponseModels;

  factory ProfileCandidateResponseModels.fromJson(Map<String, dynamic> json) =>
      _$ProfileCandidateResponseModelsFromJson(json);
}
