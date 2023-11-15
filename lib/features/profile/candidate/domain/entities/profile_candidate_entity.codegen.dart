import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/jobs_skill/domain/entities/jobs_skill_entity.codegen.dart";
import "package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart";

part "profile_candidate_entity.codegen.freezed.dart";

@freezed
class ProfileCandidateEntity with _$ProfileCandidateEntity {
  factory ProfileCandidateEntity({
    required int id,
    required int userId,
    String? uniqueId,
    String? fatherName,
    int? maritalStatusId,
    String? nationality,
    String? nationalIdCard,
    int? experience,
    int? careerLevelId,
    int? industryId,
    int? functionalAreaId,
    double? currentSalary,
    double? expectedSalary,
    dynamic salaryCurrency,
    String? address,
    bool? immediateAvailable,
    String? availableAt,
    String? avatar,
    dynamic jobAlert,
    String? candidateUrl,
    UserEntity? user,
   @Default([]) List<JobsSkillEntity> candidateSkill,
  }) = _ProfileCandidateEntity;
}
