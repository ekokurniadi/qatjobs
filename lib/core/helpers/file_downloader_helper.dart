import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:oktoast/oktoast.dart';
import 'package:qatjobs/core/helpers/dio_helper.dart';

class FileDownloaderHelper {
  const FileDownloaderHelper._();
  static Future<File?> downloadTask(String url, String name) async {
    try {
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
      return file;
    } catch (e) {
      showToast(e.toString());
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
