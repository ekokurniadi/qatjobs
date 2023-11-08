import 'dart:developer';

import 'package:qatjobs/core/widget/loading_dialog_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherHelper{
  const UrlLauncherHelper._();

  static Future<void> openUrl(String url)async{
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri);
    } catch (e) {
      log(e.toString());
      LoadingDialog.showError(message: 'Something when wrong when try to opened link');
    }
  }
}