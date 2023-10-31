import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/currency/data/models/currency_model.codegen.dart";
import 'currency_remote_datasource.dart';

@LazySingleton(as: CurrencyRemoteDataSource)
class CurrencyRemoteDataSourceImpl
    implements CurrencyRemoteDataSource {
  final Dio _dio;
  const CurrencyRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<CurrencyModel>>> getCurrency(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.currencies);
      if (response.isOk) {
        return right(
          List<CurrencyModel>.from(
            response.data.map(
              (e) => CurrencyModel.fromJson(e),
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
