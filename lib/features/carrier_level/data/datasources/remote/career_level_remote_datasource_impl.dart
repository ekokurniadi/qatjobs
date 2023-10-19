import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/carrier_level/data/models/career_level_model.codegen.dart";
import "career_level_remote_datasource.dart";

@LazySingleton(as: CareerLevelRemoteDataSource)
class CareerLevelRemoteDataSourceImpl implements CareerLevelRemoteDataSource {
  final Dio _dio;
  const CareerLevelRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<CareerLevelModel>>> getCareerLevel(
    NoParams params,
  ) async {
    try {
      final response = await _dio.get(URLConstant.careerLevel);
      if (response.isOk) {
        return right(
          List<CareerLevelModel>.from(
            response.data.map(
              (e) => CareerLevelModel.fromJson(e),
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
