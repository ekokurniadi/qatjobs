part of 'article_bloc.dart';

@freezed
class ArticleEvent with _$ArticleEvent {
  const factory ArticleEvent.getDetailArticle(int articleId) = _GetDetailArticle;
  const factory ArticleEvent.getArticle(PagingRequestParams params) = _GetArticles;
}