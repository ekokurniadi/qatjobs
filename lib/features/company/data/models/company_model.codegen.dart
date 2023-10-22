import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/users/data/models/users_model.codegen.dart";

part "company_model.codegen.freezed.dart";
part "company_model.codegen.g.dart";

@freezed
class CompanyModel with _$CompanyModel {
  factory CompanyModel({
    int? id,
    String? ceo,
    int? noOfOffices,
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
    UserModel? user,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
}
