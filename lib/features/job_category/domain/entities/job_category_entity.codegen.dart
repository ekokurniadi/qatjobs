import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart";

part "job_category_entity.codegen.freezed.dart";

@freezed
class JobCategoryEntity with _$JobCategoryEntity {
  factory JobCategoryEntity({
    required int id,
    required String name,
    required String description,
    required bool isFeatured,
    String? imageUrl,
    bool? isDefault,
    String? isFeaturedLabel,
    dynamic jobsCount,
  }) = _JobCategoryEntity;
}


extension JobCategoryEntityX on JobCategoryEntity {
  JobCategoryModel toModel() => JobCategoryModel(
        id: id,
        name: name,
        description: description,
        isFeatured: isFeatured,
        imageUrl: imageUrl,
        isDefault: isDefault,
        isFeaturedLabel: isFeaturedLabel,
        jobsCount: jobsCount,
      );
}
