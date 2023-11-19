import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart';
import 'package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart';
import 'package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_education_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/profile_candidate_models.codegen.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

part "cv_builder_models.codegen.freezed.dart";
part "cv_builder_models.codegen.g.dart";

@freezed
class CvBuilderModels with _$CvBuilderModels {
  factory CvBuilderModels({
    UserModel? user,
    CareerLevelModel? careerLevel,
    FunctionalAreaModel? functionalArea,
    List<CandidateEducationModels>? educations,
    List<CandidateExperienceModels>? experiences,
  }) = _CvBuilderModels;

  factory CvBuilderModels.fromJson(Map<String, dynamic> json) =>
      _$CvBuilderModelsFromJson(json);
}

@freezed
class CvBuilderResponseModels with _$CvBuilderResponseModels {
  const factory CvBuilderResponseModels({
    required CvBuilderModels candidate,
    required List<JobsSkillModel> candidateSkill,
  }) = _CvBuilderResponseModels;

  factory CvBuilderResponseModels.fromJson(Map<String, dynamic> json) =>
      _$CvBuilderResponseModelsFromJson(json);
}

@freezed
class CandidateDetailModels with _$CandidateDetailModels {
  factory CandidateDetailModels({
    @JsonKey(name: 'isReportedToCandidate') bool? isReportedToCandidate,
    @JsonKey(name: 'candidateDetails')
    required ProfileCandidateModels candidateDetails,
    @JsonKey(name: 'candidateEducations')
    List<CandidateEducationModels>? educations,
    @JsonKey(name: 'candidateExperiences')
    List<CandidateExperienceModels>? experiences,
  }) = _CandidateDetailModels;

  factory CandidateDetailModels.fromJson(Map<String, dynamic> json) =>
      _$CandidateDetailModelsFromJson(json);
}
