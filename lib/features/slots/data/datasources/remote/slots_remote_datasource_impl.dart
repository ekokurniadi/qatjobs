import "package:dartz/dartz.dart";
import "package:dio/dio.dart";
import "package:injectable/injectable.dart";
import "package:qatjobs/core/constant/url_constant.dart";
import "package:qatjobs/core/error/failures.dart";
import "package:qatjobs/core/extensions/dio_response_extension.dart";
import "package:qatjobs/core/helpers/dio_helper.dart";
import "package:qatjobs/features/slots/data/models/candidate_slot_model.dart";
import "package:qatjobs/features/slots/domain/usecases/cancel_slot_usecase.dart";
import "package:qatjobs/features/slots/domain/usecases/create_slot_usecase.dart";
import "slots_remote_datasource.dart";
import "package:qatjobs/features/slots/data/models/slots_model.codegen.dart";

@LazySingleton(as: SlotsRemoteDataSource)
class SlotsRemoteDataSourceImpl implements SlotsRemoteDataSource {
  final Dio _dio;
  const SlotsRemoteDataSourceImpl(this._dio);
  @override
  Future<Either<Failures, SlotsModel>> getSlots(int params) async {
    try {
      final response = await _dio.get(URLConstant.employerJobSlots(params));
      if (response.isOk) {
        return right(SlotsModel.fromJson(response.data['data']));
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
  Future<Either<Failures, bool>> createSlot(
      List<SlotRequestParams> params) async {
    try {
      final response = await _dio.post(
        URLConstant.employerJobSlots(params.first.applicationsId),
        data: List<Map<String, dynamic>>.from(
          params.map(
            (e) => e.toJson(),
          ),
        ),
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
  Future<Either<Failures, bool>> cancelSlot(
      CancelSlotRequestParams params) async {
    try {
      Map<String, dynamic> req = {};
      req['cancelSlotNote'] = [params.notes];

      final response = await _dio.post(
        '${URLConstant.employerJobSlots(params.applicationsId)}/${params.slotId}/cancel',
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
  Future<Either<Failures, CandidateSlots>> getCandidateSlots(int params) async {
    try {
      final response = await _dio.get(URLConstant.candidateJobSlots(params));
      if (response.isOk) {
        return right(CandidateSlots.fromMap(response.data['data']));
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
