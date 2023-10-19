import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article/data/datasources/remote/article_remote_datasource.dart";
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
      NoParams params) async {
    return await _articleRemoteDataSource.getArticle(params);
  }
}
