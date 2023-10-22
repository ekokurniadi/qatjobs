import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/models/paging_request_params.codegen.dart";

import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article/data/models/article_model.codegen.dart";
import "package:qatjobs/features/article/domain/repositories/article_repository.dart";

@injectable
class GetArticleUseCase implements UseCase<List<ArticleModel>, PagingRequestParams> {
  final ArticleRepository _articleRepository;

  GetArticleUseCase({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  @override
  Future<Either<Failures, List<ArticleModel>>> call(PagingRequestParams params) async {
    return await _articleRepository.getArticle(params);
  }
}

