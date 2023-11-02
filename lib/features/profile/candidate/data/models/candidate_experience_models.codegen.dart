import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/candidate_experience_entity.codegen.dart';

part "candidate_experience_models.codegen.freezed.dart";
part "candidate_experience_models.codegen.g.dart";

@freezed
class CandidateExperienceModels with _$CandidateExperienceModels {
  const factory CandidateExperienceModels({
    required int id,
    required int candidateId,
    required String experienceTitle,
    required String startDate,
     required String company,
    String? endDate,
    required bool currentlyWorking,
    String? description,
  }) = _CandidateExperienceModels;

  factory CandidateExperienceModels.fromJson(Map<String, dynamic> json) =>
      _$CandidateExperienceModelsFromJson(json);
}

extension CandidateExperienceModelsX on CandidateExperienceModels {
  CandidateExperienceEntity toDomain() => CandidateExperienceEntity(
        id: id,
        candidateId: candidateId,
        experienceTitle: experienceTitle,
        startDate: startDate,
        currentlyWorking: currentlyWorking,
        description: description,
        endDate: endDate,
        company: company,
      );
}
