import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/article_category/domain/entities/article_category_entity.codegen.dart";

part "article_category_model.codegen.freezed.dart";
part "article_category_model.codegen.g.dart";

@freezed
class ArticleCategoryModel with _$ArticleCategoryModel {
  const factory ArticleCategoryModel({
    required int id,
    required String name,
    required String description,
  }) = _ArticleCategoryModel;

  factory ArticleCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleCategoryModelFromJson(json);
}

extension ArticleCategoryModelX on ArticleCategoryModel {
  ArticleCategoryEntity toDomain() => ArticleCategoryEntity(
        id: id,
        name: name,
        description: description,
      );
}
