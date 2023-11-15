import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart';
import 'package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart';
import 'package:qatjobs/features/jobs_skill/data/models/jobs_skill_model.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_education_models.codegen.dart';
import 'package:qatjobs/features/profile/candidate/data/models/candidate_experience_models.codegen.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

part "cv_builder_models.codegen.freezed.dart";
part "cv_builder_models.codegen.g.dart";

@freezed
class CvBuilderModels with _$CvBuilderModels {
  const factory CvBuilderModels({
    required UserModel user,
    required CareerLevelModel careerLevel,
    required FunctionalAreaModel functionalArea,
    required List<CandidateEducationModels> educations,
    required List<CandidateExperienceModels> experiences,
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
