import "package:freezed_annotation/freezed_annotation.dart";

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
  }) = _JobCategoryModel;

  factory JobCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$JobCategoryModelFromJson(json);
}
