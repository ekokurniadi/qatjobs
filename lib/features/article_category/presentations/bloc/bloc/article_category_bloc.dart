import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/article_category/data/models/article_category_model.codegen.dart';
import 'package:qatjobs/features/article_category/domain/entities/article_category_entity.codegen.dart';
import 'package:qatjobs/features/article_category/domain/usecases/get_all_article_category_usecase.dart';

part 'article_category_event.dart';
part 'article_category_state.dart';
part 'article_category_bloc.freezed.dart';

@injectable
class ArticleCategoryBloc
    extends Bloc<ArticleCategoryEvent, ArticleCategoryState> {
  final GetAllArticleCategoryUseCase _getAllArticleCategoryUseCase;
  ArticleCategoryBloc(
    this._getAllArticleCategoryUseCase,
  ) : super(ArticleCategoryState.initial()) {
    on<_Started>(_getAllArticleCategory);
  }
  FutureOr<void> _getAllArticleCategory(
    _Started event,
    Emitter<ArticleCategoryState> emit,
  ) async {
    emit(state.copyWith(status: ArticleCategoryStatus.loading));

    final result = await _getAllArticleCategoryUseCase(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: ArticleCategoryStatus.loading,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
            status: ArticleCategoryStatus.success,
            articleCategories: List.from(
              r.map(
                (e) => e.toDomain(),
              ),
            )),
      ),
    );
  }
}
