import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickers {
  File? imagePath;

  Future pickImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        imagePath = null;
      } else {
        imagePath = File(image.path);
      }
    } on PlatformException catch (e) {
      throw e;
    } catch (e) {
      print(e);
    }
    return imagePath;
  }
}
