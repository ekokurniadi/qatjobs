import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/users/domain/entitites/users_entity.codegen.dart";

part "company_entity.codegen.freezed.dart";

@freezed
class CompanyEntity with _$CompanyEntity {
  factory CompanyEntity({
    int? id,
    String? ceo,
    String? noOfOffices,
    int? userId,
    dynamic submissionStatusId,
    int? industryId,
    int? ownershipTypeId,
    int? companySizeId,
    int? establishedIn,
    String? details,
    String? website,
    String? location,
    String? location2,
    dynamic isFeatured,
    String? fax,
    String? uniqueId,
    String? companyUrl,
    UserEntity? user,
  }) = _CompanyEntity;
}
