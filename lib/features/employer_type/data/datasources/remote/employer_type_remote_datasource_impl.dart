import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/employer_type/data/datasources/remote/employer_type_remote_datasource.dart";
import "package:qatjobs/features/employer_type/data/models/employer_type_model.codegen.dart";

@LazySingleton(as: EmployerTypeRemoteDataSource)
class EmployerTypeRemoteDataSourceImpl implements EmployerTypeRemoteDataSource {
  final Dio _dio;
  const EmployerTypeRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<EmployerTypeModel>>> getEmployerType(
      NoParams params) async {
    try {
      final response = await _dio.get(URLConstant.ownerShipTypes);
      if (response.isOk) {
        return right(
          List<EmployerTypeModel>.from(
            response.data.map(
              (e) => EmployerTypeModel.fromJson(e),
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
