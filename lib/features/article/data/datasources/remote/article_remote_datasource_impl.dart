import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/helpers/global_helper.dart";
import "package:qatjobs/core/models/paging_request_params.codegen.dart";
import "package:qatjobs/features/article/data/models/article_detail_model.codegen.dart";
import "package:qatjobs/features/article/data/models/article_model.codegen.dart";
import "article_remote_datasource.dart";

@LazySingleton(as: ArticleRemoteDataSource)
class ArticleRemoteDataSourceImpl implements ArticleRemoteDataSource {
  final Dio _dio;
  const ArticleRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<ArticleModel>>> getArticle(
    PagingRequestParams params,
  ) async {
    try {
      final url = GlobalHelper.isEmpty(params.id)
          ? URLConstant.article
          : '${URLConstant.articleByCategoryId}${params.id}';
      final parameter = params.copyWith(id: null);
      final response = await _dio.get(
        url,
        queryParameters: parameter.toJson(),
      );

      if (response.isOk) {
        return right(
          List<ArticleModel>.from(
            response.data['blogs']['data'].map(
              (e) => ArticleModel.fromJson(e),
            ),
          ),
        );
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    }
  }

  @override
  Future<Either<Failures, ArticleDetailModel>> getArticleDetail(
      int params) async {
    try {
      final response = await _dio.get('${URLConstant.articleDetail}/$params');

      if (response.isOk) {
        return right(ArticleDetailModel.fromJson(response.data['article']));
      }
      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    }
  }
}
