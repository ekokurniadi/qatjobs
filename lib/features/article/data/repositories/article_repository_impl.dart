import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/models/paging_request_params.codegen.dart";
import "package:qatjobs/features/article/data/datasources/remote/article_remote_datasource.dart";
import "package:qatjobs/features/article/data/models/article_detail_model.codegen.dart";
import "package:qatjobs/features/article/data/models/article_model.codegen.dart";
import "package:qatjobs/features/article/domain/repositories/article_repository.dart";

@LazySingleton(as: ArticleRepository)
class ArticleRepositoryImpl implements ArticleRepository {
  final ArticleRemoteDataSource _articleRemoteDataSource;

  const ArticleRepositoryImpl({
    required ArticleRemoteDataSource articleRemoteDataSource,
  }) : _articleRemoteDataSource = articleRemoteDataSource;

  @override
  Future<Either<Failures, List<ArticleModel>>> getArticle(
      PagingRequestParams params) async {
    return await _articleRemoteDataSource.getArticle(params);
  }

  @override
  Future<Either<Failures, ArticleDetailModel>> getArticleDetail(
      int params) async {
    return await _articleRemoteDataSource.getArticleDetail(params);
  }

  @override
  Future<Either<Failures, List<ArticleModel>>> getArticleByCategory(
      PagingRequestParams params) async {
   return await _articleRemoteDataSource.getArticleByCategory(params);
  }
}
