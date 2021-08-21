import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:uuid/uuid.dart';

class ImagePickers {
  var uuid = Uuid();

  Future pickImage() async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        // maybe alert something
        return;
      } else {
        var v4 = uuid.v4();
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/$v4.png')
            .putFile(File(image.path));
      }
    } on PlatformException catch (e) {
      throw e;
    } on firebase_core.FirebaseException catch (e) {
      throw e;
    } catch (e) {
      print(e);
    }
  }
}
