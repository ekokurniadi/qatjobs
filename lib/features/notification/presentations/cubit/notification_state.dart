part of 'notification_cubit.dart';

enum NotifStatus { initial, loading, complete, failure, readAll }

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState({
    required NotifStatus status,
    required List<NotificationModel> notifications,
    required String message,
  }) = _NotificationState;

  factory NotificationState.initial() => const NotificationState(
        status: NotifStatus.initial,
        notifications: [],
        message: '',
      );
}
