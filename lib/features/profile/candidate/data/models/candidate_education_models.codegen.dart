import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:qatjobs/features/profile/candidate/domain/entities/candidate_education_entity.codegen.dart';

part "candidate_education_models.codegen.freezed.dart";
part "candidate_education_models.codegen.g.dart";

@freezed
class CandidateEducationModels with _$CandidateEducationModels {
  const factory CandidateEducationModels({
    required int id,
    required int degreeLevelId,
    required String degreeTitle,
    required String institute,
    required String result,
    required int year,
  }) = _CandidateEducationModels;

  factory CandidateEducationModels.fromJson(Map<String, dynamic> json) =>
      _$CandidateEducationModelsFromJson(json);
}

extension CandidateEducationModelsX on CandidateEducationModels {
  CandidateEducationEntity toDomain() => CandidateEducationEntity(
        id: id,
        degreeLevelId: degreeLevelId,
        degreeTitle: degreeTitle,
        institute: institute,
        result: result,
        year: year,
      );
}
