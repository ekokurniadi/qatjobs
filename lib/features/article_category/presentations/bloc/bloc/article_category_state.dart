part of 'article_category_bloc.dart';

enum ArticleCategoryStatus { initial, loading, success, failure }

@freezed
class ArticleCategoryState with _$ArticleCategoryState {
  const factory ArticleCategoryState({
    required ArticleCategoryStatus status,
    required String message,
    required List<ArticleCategoryEntity> articleCategories,
  }) = _ArticleCategoryState;

  factory ArticleCategoryState.initial() => const ArticleCategoryState(
        status: ArticleCategoryStatus.initial,
        message: '',
        articleCategories: [],
      );
}
