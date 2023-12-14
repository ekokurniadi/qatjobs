import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file/open_file.dart';
import 'package:qatjobs/core/helpers/global_helper.dart';
import 'package:qatjobs/features/layouts/presentations/cubit/bottom_nav_cubit.dart';
import 'package:qatjobs/injector.dart';

class NotificationService {
  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await notificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {},
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
      macOS: initializationSettingsIOS,
    );
    await notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {
        final payloadData = notificationResponse.payload;

        if (!GlobalHelper.isEmpty(payloadData)) {
          if (payloadData!.contains('action')) {
            getIt<BottomNavCubit>().setSelectedMenuIndex(3);
          } else {
            await OpenFile.open(payloadData);
          }
        }
      },
    );
  }

  _notificationDetails(int count, int progress, bool isOnlyOnce) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'download_channel_id',
        'download_channel_name',
        channelDescription: 'channel_download',
        channelShowBadge: true,
        priority: Priority.high,
        importance: Importance.max,
        playSound: true,
        onlyAlertOnce: isOnlyOnce,
        tag: 'download_tag',
        maxProgress: count,
        progress: progress,
        showProgress: count > 0,
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    int? count,
    int? progress,
    String? title,
    String? body,
    String? payLoad,
    bool? isOnlyOnce,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      _notificationDetails((count ?? 0), (progress ?? 0), isOnlyOnce ?? false),
      payload: payLoad,
    );
  }

  Future<void> closeNotification({
    int id = 0,
    String? title,
    String? body,
    String? payLoad,
  }) async {
    return notificationsPlugin.cancel(
      id,
      tag: 'download_tag',
    );
  }

  Future<void> cancelAll() async {
    return notificationsPlugin.cancelAll();
  }
}
