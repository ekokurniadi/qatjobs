import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/article_category/data/models/article_category_model.codegen.dart";

abstract class ArticleCategoryRemoteDataSource {
  Future<Either<Failures, List<ArticleCategoryModel>>> getAllArticleCategory(
    NoParams params,
  );
}
