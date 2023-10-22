import "package:freezed_annotation/freezed_annotation.dart";

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
