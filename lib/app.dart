import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'injector.dart';

class App {
  const App._();

  static Future<void> init() async {
    DioHelper.initialDio("");
    DioHelper.setDioLogger("");
    String? token = getIt<SharedPreferences>().getString("token");
    DioHelper.setDioHeader(token);
  }
}
