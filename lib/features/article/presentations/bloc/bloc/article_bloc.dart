import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/models/paging_request_params.codegen.dart';
import 'package:qatjobs/features/article/data/models/article_detail_model.codegen.dart';
import 'package:qatjobs/features/article/data/models/article_model.codegen.dart';
import 'package:qatjobs/features/article/domain/usecases/get_article_by_category_usecase.dart';
import 'package:qatjobs/features/article/domain/usecases/get_article_details.dart';
import 'package:qatjobs/features/article/domain/usecases/get_article_usecase.dart';

part 'article_event.dart';
part 'article_state.dart';
part 'article_bloc.freezed.dart';

@injectable
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticleDetailUseCase _getArticleDetailUseCase;
  final GetArticleUseCase _getArticleUseCase;
  final GetArticleByCategoryUseCase _getArticleByCategoryUseCase;
  ArticleBloc(
    this._getArticleDetailUseCase,
    this._getArticleUseCase,
    this._getArticleByCategoryUseCase,
  ) : super(ArticleState.initial()) {
    on<_GetDetailArticle>(_onGetArticle);
    on<_GetArticles>(_onGetAllArticle);
    on<_GetArticleByCategory>(_onGetArticleByCategory);
  }

  FutureOr<void> _onGetArticle(
    _GetDetailArticle event,
    Emitter<ArticleState> emit,
  ) async {
    emit(state.copyWith(status: ArticleStatus.loading));
    final result = await _getArticleDetailUseCase(event.articleId);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ArticleStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: ArticleStatus.complete,
          articleDetail: r,
        ),
      ),
    );
  }

  FutureOr<void> _onGetArticleByCategory(
    _GetArticleByCategory event,
    Emitter<ArticleState> emit,
  ) async {
    emit(state.copyWith(status: ArticleStatus.loading, isByCategory: true));
    final result = await _getArticleByCategoryUseCase(event.params);
    state.articlesByCategory.removeWhere(
      (element) => element.postAssignCategories.first['id'] != event.params.id,
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          status: ArticleStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => r.isEmpty
          ? emit(
              state.copyWith(
                hasMaxReached: true,
                status: ArticleStatus.complete,
              ),
            )
          : emit(
              state.copyWith(
                status: ArticleStatus.complete,
                articlesByCategory:
                    (state.articlesByCategory + r).toSet().toList(),
                articles: [],
                currentPage: event.params.page ?? 1,
              ),
            ),
    );
  }

  FutureOr<void> _onGetAllArticle(
    _GetArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(state.copyWith(status: ArticleStatus.loading, isByCategory: false));
    final result = await _getArticleUseCase(event.params);

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ArticleStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => r.isEmpty
          ? emit(
              state.copyWith(
                hasMaxReached: true,
                status: ArticleStatus.complete,
              ),
            )
          : emit(
              state.copyWith(
                status: ArticleStatus.complete,
                articles: (state.articles + r).toSet().toList(),
                articlesByCategory: [],
                currentPage: event.params.page ?? 1,
              ),
            ),
    );
  }
}
