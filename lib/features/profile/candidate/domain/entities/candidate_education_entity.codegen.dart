import 'package:freezed_annotation/freezed_annotation.dart';

part "candidate_education_entity.codegen.freezed.dart";

@freezed
class CandidateEducationEntity with _$CandidateEducationEntity {
  const factory CandidateEducationEntity({
    required int id,
    required int degreeLevelId,
    required String degreeTitle,
    required String institute,
    required String result,
    required int year,
  }) = _CandidateEucationEntity;
}
