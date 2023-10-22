part of 'article_bloc.dart';

enum ArticleStatus { initial, loading, complete, failure }

@freezed
class ArticleState with _$ArticleState {
  factory ArticleState({
    required ArticleStatus status,
    ArticleDetailModel? articleDetail,
    required List<ArticleModel> articles,
    required String message,
    required bool hasMaxReached,
    required int currentPage,
  }) = _ArticleState;

  factory ArticleState.initial() => ArticleState(
        status: ArticleStatus.initial,
        articleDetail: null,
        message: '',
        articles: [],
        hasMaxReached: false,
        currentPage: 0,
      );
}
