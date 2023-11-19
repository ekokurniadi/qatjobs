import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qatjobs/core/extensions/dio_response_extension.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/usecases/usecases.dart';
import 'package:qatjobs/features/notification/data/models/notification_models.codegen.dart';
import 'package:qatjobs/features/notification/domain/usecases/get_notification_usecase.dart';

part 'notification_state.dart';
part 'notification_cubit.freezed.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  final GetNotification _getNotification;
  NotificationCubit(
    this._getNotification,
  ) : super(NotificationState.initial());

  Future<void> getNotif() async {
    emit(state.copyWith(status: NotifStatus.loading));
    final result = await _getNotification(NoParams());

    result.fold(
      (l) => emit(
        state.copyWith(
          status: NotifStatus.failure,
          message: l.errorMessage,
        ),
      ),
      (r) => emit(
        state.copyWith(
          status: NotifStatus.complete,
          notifications: r,
        ),
      ),
    );
  }

  Future<void> readAll() async {
    emit(state.copyWith(status: NotifStatus.loading));
    try {
      final response =
          await DioHelper.dio!.post('/employer/notifications/read-all');
      if (response.isOk) {
        emit(
          state.copyWith(
            status: NotifStatus.readAll,
            message: 'Read All Message',
          ),
        );
      }
    } on DioError catch (e) {
      emit(
        state.copyWith(
          status: NotifStatus.failure,
          message: DioHelper.formatException(e),
        ),
      );
    }
  }
}
