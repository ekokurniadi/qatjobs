import 'package:freezed_annotation/freezed_annotation.dart';

part "candidate_experience_entity.codegen.freezed.dart";

@freezed
class CandidateExperienceEntity with _$CandidateExperienceEntity {
  const factory CandidateExperienceEntity({
    required int id,
    required int candidateId,
    required String experienceTitle,
    required String startDate,
    required String company,
    String? endDate,
    required bool currentlyWorking,
    String? description,
  }) = _CandidateExperienceEntity;
}
