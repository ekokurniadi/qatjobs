import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/job_category/domain/entities/job_category_entity.codegen.dart";

part "job_category_model.codegen.freezed.dart";
part "job_category_model.codegen.g.dart";

@freezed
class JobCategoryModel with _$JobCategoryModel {
  factory JobCategoryModel({
    required int id,
    required String name,
    required String description,
    required bool isFeatured,
    String? imageUrl,
    bool? isDefault,
    String? isFeaturedLabel,
    String? jobsCount,
  }) = _JobCategoryModel;

  factory JobCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$JobCategoryModelFromJson(json);
}

extension JobCategoryModelX on JobCategoryModel {
  JobCategoryEntity toDomain() => JobCategoryEntity(
        id: id,
        name: name,
        description: description,
        isFeatured: isFeatured,
        imageUrl: imageUrl,
        isDefault: isDefault,
        isFeaturedLabel: isFeaturedLabel,
      );
}
