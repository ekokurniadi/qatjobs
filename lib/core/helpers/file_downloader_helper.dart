import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/helpers/notification_helper.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';

class FileDownloaderHelper {
  const FileDownloaderHelper._();
  static Future<File?> downloadTask(String url, String name) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      final basePath = await _getDownloadPath();
      String savePath = join(basePath ?? '', name);
      File file = File(savePath);

      NotificationService().showNotification(
        id: 1,
        title: 'Download file $name',
        payLoad: file.path,
      );

      final response = await DioHelper.dio!.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      var raw = file.openSync(mode: FileMode.write);
      raw.writeFromSync(response.data);
      await raw.close();

      return file;
    } catch (e) {
      LoadingDialog.showError(message: e.toString());
      EasyLoading.dismiss();
      return null;
    }
  }

  static Future<String?> _getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');

        if (!await directory.exists()) {
          directory = await getExternalStorageDirectory();
        }
      }
    } catch (err) {
      log("Cannot get download folder path");
    }
    return directory?.path;
  }
}
