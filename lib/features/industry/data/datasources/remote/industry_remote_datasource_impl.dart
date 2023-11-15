import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/industry/data/datasources/remote/industry_remote_datasource.dart";
import "package:qatjobs/features/industry/data/models/industry_model.codegen.dart";

@LazySingleton(as: IndustryRemoteDataSource)
class IndustryRemoteDataSourceImpl implements IndustryRemoteDataSource {
  final Dio _dio;
  const IndustryRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<IndustryModel>>> getIndustry(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.industry);
      if (response.isOk) {
        return right(
          List<IndustryModel>.from(
            response.data.map(
              (e) => IndustryModel.fromJson(e),
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
