import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/profile/candidate/domain/entities/profile_candidate_entity.codegen.dart";
import "package:qatjobs/features/users/data/models/users_model.codegen.dart";

part "profile_candidate_models.codegen.freezed.dart";
part "profile_candidate_models.codegen.g.dart";

@freezed
class ProfileCandidateModels with _$ProfileCandidateModels {
  factory ProfileCandidateModels({
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
    dynamic jobAlert,
    String? candidateUrl,
    UserModel? user,
  }) = _ProfileCandidateModels;

  factory ProfileCandidateModels.fromJson(Map<String, dynamic> json) =>
      _$ProfileCandidateModelsFromJson(json);
}

extension ProfileCandidateModelsX on ProfileCandidateModels {
  ProfileCandidateEntity toDomain() => ProfileCandidateEntity(
        id: id,
        userId: userId,
        address: address,
        availableAt: availableAt,
        candidateUrl: candidateUrl,
        careerLevelId: careerLevelId,
        currentSalary: currentSalary,
        expectedSalary: expectedSalary,
        experience: experience,
        fatherName: fatherName,
        functionalAreaId: functionalAreaId,
        immediateAvailable: immediateAvailable,
        industryId: industryId,
        jobAlert: jobAlert,
        maritalStatusId: maritalStatusId,
        nationalIdCard: nationalIdCard,
        nationality: nationality,
        salaryCurrency: salaryCurrency,
        uniqueId: uniqueId,
        user: user?.toDomain(),
      );
}
