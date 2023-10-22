import "package:freezed_annotation/freezed_annotation.dart";
import "package:qatjobs/features/article/data/models/article_model.codegen.dart";

part "article_detail_model.codegen.freezed.dart";
part "article_detail_model.codegen.g.dart";

@freezed
class ArticleDetailModel with _$ArticleDetailModel {
  factory ArticleDetailModel({
    required ArticleModel blog,
    Map<String, dynamic>? shareUrl,
    List<Map<String, dynamic>>? comments,
  }) = _ArticleDetailModel;

  factory ArticleDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ArticleDetailModelFromJson(json);
}
