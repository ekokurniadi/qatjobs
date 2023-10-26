part of 'article_bloc.dart';

enum ArticleStatus { initial, loading, complete, failure }

@freezed
class ArticleState with _$ArticleState {
  factory ArticleState({
    required ArticleStatus status,
    ArticleDetailModel? articleDetail,
    required List<ArticleModel> articles,
    required List<ArticleModel> articlesByCategory,
    required String message,
    required bool hasMaxReached,
    required bool isByCategory,
    required int currentPage,
  }) = _ArticleState;

  factory ArticleState.initial() => ArticleState(
        status: ArticleStatus.initial,
        articleDetail: null,
        message: '',
        articles: [],
        hasMaxReached: false,
        currentPage: 0,
        articlesByCategory:[],
        isByCategory: false,
      );
}
