import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article/data/models/article_model.codegen.dart";

abstract class ArticleRepository {
	Future<Either<Failures,List<ArticleModel>>> getArticle(NoParams params);
}
