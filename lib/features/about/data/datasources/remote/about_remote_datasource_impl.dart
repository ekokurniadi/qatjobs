import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "about_remote_datasource.dart";
import "package:qatjobs/features/about/data/models/about_model.codegen.dart";

@LazySingleton(as: AboutRemoteDataSource)
class AboutRemoteDataSourceImpl implements AboutRemoteDataSource {
  final Dio _dio;
  const AboutRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<AboutModel>>> getAbout(
    NoParams params,
  ) async {
    try {
      final response = await _dio.get(URLConstant.aboutUs);

      if (response.isOk) {
        return right(
          List.from(
            response.data['data']['faqLists'].map(
              (e) => AboutModel.fromJson(e),
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
}
