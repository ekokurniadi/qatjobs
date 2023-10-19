import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/users/data/models/users_model.codegen.dart";

part "article_model.codegen.freezed.dart";
part "article_model.codegen.g.dart";

@freezed
class ArticleModel with _$ArticleModel {
  const factory ArticleModel({
    required int id,
    required String title,
    required String description,
    required String createdAt,
    required bool isDefault,
    required String commentsCount,
    required String blogImageUrl,
    required List<Map<String, dynamic>> postAssignCategories,
    required UserModel user,
  }) = _ArticleModel;

  factory ArticleModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleModelFromJson(json);
}
