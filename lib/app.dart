import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qatjobs/core/constant/url_constant.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.dart';

class App {
  const App._();

  static Future<void> init() async {
    DioHelper.initialDio(URLConstant.baseURL);
    DioHelper.setDioLogger(URLConstant.baseURL);
    String? token = getIt<SharedPreferences>().getString("token");
    DioHelper.setDioHeader(token);
    await NotificationService().initNotification();
  }
}
