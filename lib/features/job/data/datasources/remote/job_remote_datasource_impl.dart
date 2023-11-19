import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/core/helpers/global_helper.dart";
import "package:qatjobs/core/usecases/usecases.dart";
import "package:qatjobs/features/job/data/models/applied_job_model.codegen.dart";
import "package:qatjobs/features/job/data/models/favorite_job_model.codegen.dart";
import "package:qatjobs/features/job/data/models/job_alert_request_params.codegen.dart";
import "package:qatjobs/features/job/data/models/job_alerts_model.codegen.dart";
import "package:qatjobs/features/job/data/models/job_filter.codegen.dart";
import "package:qatjobs/features/job/domain/usecases/apply_job_usecase.dart";
import "package:qatjobs/features/job/domain/usecases/email_to_friend_usecase.dart";
import "package:qatjobs/features/job/domain/usecases/save_to_favorite_job_usecase.dart";
import "job_remote_datasource.dart";
import "package:qatjobs/features/job/data/models/job_model.codegen.dart";

@LazySingleton(as: JobRemoteDataSource)
class JobRemoteDataSourceImpl implements JobRemoteDataSource {
  const JobRemoteDataSourceImpl(this._dio);

  final Dio _dio;
  @override
  Future<Either<Failures, List<JobModel>>> getAJob(
      JobFilterModel params) async {
    try {
      final response = await _dio.post(
        URLConstant.jobSearch,
        data: params.toJson(),
      );

      if (response.isOk) {
        if (!GlobalHelper.isEmpty(response.data['data'])) {
          final result = List<JobModel>.from(
            response.data['data'].map(
              (e) => JobModel.fromJson(e),
            ),
          );
          return right(result);
        }
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

  @override
  Future<Either<Failures, List<FavoriteJobModel>>> getFavoriteJob(
      NoParams params) async {
    try {
      final response = await _dio.get(
        URLConstant.candidateFavoriteJob,
      );

      if (response.isOk) {
        if (!GlobalHelper.isEmpty(response.data)) {
          final result = List<FavoriteJobModel>.from(
            response.data.map(
              (e) => FavoriteJobModel.fromJson(e),
            ),
          );
          return right(result);
        }
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

  @override
  Future<Either<Failures, bool>> saveToFavorite(
      FavoriteJobRequestParams params) async {
    try {
      final response = await _dio.post(
        URLConstant.candidateFavoriteJob,
        data: params.toJson(),
      );

      if (response.isOk) {
        return right(response.isOk);
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

  @override
  Future<Either<Failures, bool>> deleteFavoriteJob(int params) async {
    try {
      final response = await _dio.delete(
        '${URLConstant.candidateFavoriteJob}/$params',
      );

      if (response.isOk) {
        return right(response.isOk);
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

  @override
  Future<Either<Failures, List<AppliedJobModel>>> getAppliedJob(
      NoParams params) async {
    try {
      final response = await _dio.get(
        URLConstant.candidateAppliedJob,
      );

      if (response.isOk) {
        if (!GlobalHelper.isEmpty(response.data)) {
          final result = List<AppliedJobModel>.from(
            response.data.map(
              (e) => AppliedJobModel.fromJson(e),
            ),
          );
          return right(result);
        }
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

  @override
  Future<Either<Failures, bool>> addJobAlert(
      JobAlertRequestParams params) async {
    try {
      Map<String, dynamic> req = {};
      req['job_alert'] = params.jobTypes.toString();
      req['job_types'] =
          List<String>.from(params.jobAlerts.map((e) => e.toString()));

      final response = await _dio.post(
        URLConstant.candidateJobAlert,
        data: req,
      );

      if (response.isOk) {
        return right(true);
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

  @override
  Future<Either<Failures, JobAlertsModel>> getJobAlert(NoParams params) async {
    try {
      final response = await _dio.get(
        URLConstant.candidateJobAlert,
      );

      if (response.isOk) {
        return right(JobAlertsModel.fromJson(response.data));
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

  @override
  Future<Either<Failures, bool>> applyJob(ApplyJobRequestParams params) async {
    try {
      final response = await _dio.post(
        URLConstant.candidateJobApply(params.jobId),
        data: params.toJson(),
      );

      if (response.isOk) {
        return right(true);
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

  @override
  Future<Either<Failures, bool>> emailToFriend(
      EmailToFriendRequestParams params) async {
    try {
      final response = await _dio.post(
        URLConstant.candidateJobEmailToFriend(params.jobId),
        data: params.toJson(),
      );

      if (response.isOk) {
        return right(true);
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
