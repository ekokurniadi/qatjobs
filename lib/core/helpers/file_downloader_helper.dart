import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';
import 'package:qatjobs/core/widget/loading_dialog_widget.dart';

class FileDownloaderHelper {
  const FileDownloaderHelper._();
  static Future<File?> downloadTask(String url, String name) async {
    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }

      String savePath = "/storage/emulated/0/Download/$name";
      File file = File(savePath);

      final response = await DioHelper.dio!.get(
        url,
        onReceiveProgress: _showDownloadProgress,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
        ),
      );

      var raw = file.openSync(mode: FileMode.write);
      raw.writeFromSync(response.data);
      await raw.close();
      LoadingDialog.showSuccess(message: 'Download Success');
      return file;
    } catch (e) {
      LoadingDialog.showError(message: e.toString());
      EasyLoading.dismiss();
      return null;
    }
  }

  static void _showDownloadProgress(int received, int total) {
    if (total > 0) {
      EasyLoading.showProgress(
        double.parse(((received / total * 100) / 100).toStringAsFixed(1)),
        status: 'Downloading...',
        maskType: EasyLoadingMaskType.black,
      );
    }
  }
}
