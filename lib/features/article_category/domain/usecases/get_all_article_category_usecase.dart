import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article_category/domain/repositories/article_category_repository.dart";
import "package:qatjobs/features/article_category/data/models/article_category_model.codegen.dart";

@injectable
class GetAllArticleCategoryUseCase
    implements UseCase<List<ArticleCategoryModel>, NoParams> {
  final ArticleCategoryRepository _articleCategoryRepository;

  GetAllArticleCategoryUseCase({
    required ArticleCategoryRepository articleCategoryRepository,
  }) : _articleCategoryRepository = articleCategoryRepository;

  @override
  Future<Either<Failures, List<ArticleCategoryModel>>> call(
      NoParams params) async {
    return await _articleCategoryRepository.getAllArticleCategory(params);
  }
}
