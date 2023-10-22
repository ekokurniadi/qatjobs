import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article_category/domain/repositories/article_category_repository.dart";
import "package:qatjobs/features/article_category/data/datasources/remote/article_category_remote_datasource.dart";
import "package:qatjobs/features/article_category/data/models/article_category_model.codegen.dart";

@LazySingleton(as:ArticleCategoryRepository)
class ArticleCategoryRepositoryImpl implements ArticleCategoryRepository {
  final ArticleCategoryRemoteDataSource _articleCategoryRemoteDataSource;

  const ArticleCategoryRepositoryImpl({
    required ArticleCategoryRemoteDataSource articleCategoryRemoteDataSource,
  }) : _articleCategoryRemoteDataSource = articleCategoryRemoteDataSource;

  @override
  Future<Either<Failures, List<ArticleCategoryModel>>> getAllArticleCategory(
      NoParams params) async {
    return await _articleCategoryRemoteDataSource.getAllArticleCategory(params);
  }
}
