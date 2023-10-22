import "package:dartz/dartz.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/models/paging_request_params.codegen.dart";
import "package:qatjobs/features/article/data/models/article_detail_model.codegen.dart";
import "package:qatjobs/features/article/data/models/article_model.codegen.dart";

abstract class ArticleRepository {
	Future<Either<Failures,List<ArticleModel>>> getArticle(PagingRequestParams params);
   Future<Either<Failures, ArticleDetailModel>> getArticleDetail(int params);
}
