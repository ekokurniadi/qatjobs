import "package:dartz/dartz.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article/data/models/article_model.codegen.dart";
import "article_remote_datasource.dart";

@LazySingleton(as: ArticleRemoteDataSource)
class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  @override
  Future<Either<Failures, List<ArticleModel>>> getArticle(
      NoParams params) async {
    // TODO: implement execute
    throw UnimplementedError();
  }
}
