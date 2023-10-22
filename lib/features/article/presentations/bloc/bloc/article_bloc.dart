import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/models/paging_request_params.codegen.dart';
import 'package:qatjobs/features/article/data/models/article_detail_model.codegen.dart';
import 'package:qatjobs/features/article/data/models/article_model.codegen.dart';
import 'package:qatjobs/features/article/domain/usecases/get_article_details.dart';
import 'package:qatjobs/features/article/domain/usecases/get_article_usecase.dart';

part 'article_event.dart';
part 'article_state.dart';
part 'article_bloc.freezed.dart';

@injectable
class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final GetArticleDetailUseCase _getArticleDetailUseCase;
  final GetArticleUseCase _getArticleUseCase;
  ArticleBloc(
    this._getArticleDetailUseCase,
    this._getArticleUseCase,
  ) : super(ArticleState.initial()) {
    on<_GetDetailArticle>(_onGetArticle);
    on<_GetArticles>(_onGetAllArticle);
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

  FutureOr<void> _onGetAllArticle(
    _GetArticles event,
    Emitter<ArticleState> emit,
  ) async {
    emit(state.copyWith(status: ArticleStatus.loading));
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
                  hasMaxReached: true, status: ArticleStatus.complete),
            )
          : emit(
              state.copyWith(
                status: ArticleStatus.complete,
                articles: event.params.id != null
                    ? (state.articles
                                .where(
                                  (e) =>
                                      e.postAssignCategories.first['id'] ==
                                      event.params.id,
                                )
                                .toList() +
                            r)
                        .toSet()
                        .toList()
                    : (state.articles + r).toSet().toList(),
                currentPage: event.params.page ?? 1,
              ),
            ),
    );
  }
}
