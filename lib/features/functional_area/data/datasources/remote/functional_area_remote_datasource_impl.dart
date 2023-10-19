import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "functional_area_remote_datasource.dart";
import "package:qatjobs/features/functional_area/data/models/functional_area_model.codegen.dart";

@LazySingleton(as: FunctionalAreaRemoteDataSource)
class FunctionalAreaRemoteDataSourceImpl
    implements FunctionalAreaRemoteDataSource {
  final Dio _dio;
  const FunctionalAreaRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<FunctionalAreaModel>>> getFunctionalArea(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.functionalArea);
      if (response.isOk) {
        return right(
          List<FunctionalAreaModel>.from(
            response.data.map(
              (e) => FunctionalAreaModel.fromJson(e),
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
