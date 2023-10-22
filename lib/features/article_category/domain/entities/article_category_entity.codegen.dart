import "package:freezed_annotation/freezed_annotation.dart";

part "article_category_entity.codegen.freezed.dart";

@freezed
class ArticleCategoryEntity with _$ArticleCategoryEntity {
  const factory ArticleCategoryEntity({
    required int id,
    required String name,
    required String description,
  }) = _ArticleCategoryEntity;
}
