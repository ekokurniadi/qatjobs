import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "degree_level_remote_datasource.dart";
import "package:qatjobs/features/degree_level/data/models/degree_level_model.codegen.dart";

@LazySingleton(as: DegreeLevelRemoteDataSource)
class DegreeLevelRemoteDataSourceImpl implements DegreeLevelRemoteDataSource {
  final Dio _dio;
  const DegreeLevelRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<DegreeLevelModel>>> getDegreeLevel(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.degreeLevel);
      if (response.isOk) {
        return right(
          List<DegreeLevelModel>.from(
            response.data.map(
              (e) => DegreeLevelModel.fromJson(e),
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
    } catch (e) {
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
