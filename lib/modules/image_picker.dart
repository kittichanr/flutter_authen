import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_authen/providers/ImageProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ImagePickers with ChangeNotifier {
  var uuid = Uuid();

  Future pickImage(BuildContext context) async {
    try {
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        // maybe alert something
        return;
      } else {
        var v4 = uuid.v4();
        await firebase_storage.FirebaseStorage.instance
            .ref('uploads/$v4.png')
            .putFile(
                File(image.path),
                firebase_storage.SettableMetadata(customMetadata: {
                  'uploaded_time':
                      DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
                }));
        context.read<ImgProvider>().fetchImageList();
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
