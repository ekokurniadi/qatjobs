import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "article_category_remote_datasource.dart";
import "package:qatjobs/features/article_category/data/models/article_category_model.codegen.dart";

@LazySingleton(as: ArticleCategoryRemoteDataSource)
class ArticleCategoryRemoteDataSourceImpl
    implements ArticleCategoryRemoteDataSource {
  final Dio _dio;
  const ArticleCategoryRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<ArticleCategoryModel>>> getAllArticleCategory(
    NoParams params,
  ) async {
    try {
      List<ArticleCategoryModel> result = [];

      final response = await _dio.get(URLConstant.articleCategory);

      if (response.isOk) {
        result = List<ArticleCategoryModel>.from(
          response.data.map(
            (e) => ArticleCategoryModel.fromJson(e),
          ),
        );
        result.insert(
          0,
          ArticleCategoryModel(
            id: 0,
            name: 'All Category',
            description: '',
          ),
        );
        return right(result);
      }

      return left(
        ServerFailure(
          errorMessage: response.data['message'],
        ),
      );
    } on DioError catch (e) {
      return left(
        ServerFailure(
          errorMessage: DioHelper.formatException(e),
        ),
      );
    } catch (e) {
      return left(ServerFailure(errorMessage: e.toString()));
    }
  }
}
