import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";

import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article/data/models/article_detail_model.codegen.dart";
import "package:qatjobs/features/article/domain/repositories/article_repository.dart";

@injectable
class GetArticleDetailUseCase implements UseCase<ArticleDetailModel, int> {
  final ArticleRepository _articleRepository;

  GetArticleDetailUseCase({
    required ArticleRepository articleRepository,
  }) : _articleRepository = articleRepository;

  @override
  Future<Either<Failures, ArticleDetailModel>> call(int params) async {
    return await _articleRepository.getArticleDetail(params);
  }
}
