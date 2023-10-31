import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  const ImagePickerHelper._();

  static Future<File?> pickImage({
    ImageSource? source,
  }) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile = await picker.pickImage(
      source: source ?? ImageSource.gallery,
    );
    if (pickedFile != null) {
      final File newImage = File(pickedFile.path);
      return newImage;
    }
    return null;
  }
}
