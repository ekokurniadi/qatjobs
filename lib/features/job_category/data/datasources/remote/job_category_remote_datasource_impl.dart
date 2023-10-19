import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "job_category_remote_datasource.dart";
import "package:qatjobs/features/job_category/data/models/job_category_model.codegen.dart";

@LazySingleton(as: JobCategoryRemoteDataSource)
class JobCategoryRemoteDataSourceImpl implements JobCategoryRemoteDataSource {
  final Dio _dio;
  const JobCategoryRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, List<JobCategoryModel>>> getJobCategory(
      NoParams params) async {
    try {
      List<JobCategoryModel> result = [];
      final response = await _dio.get(URLConstant.categories);
      if (response.isOk) {
        result = List<JobCategoryModel>.from(
          response.data.map(
            (e) => JobCategoryModel.fromJson(e),
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
      final message = DioHelper.formatException(e);
      return left(
        ServerFailure(
          errorMessage: message,
        ),
      );
    }catch(e){
      return left(
        ServerFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
