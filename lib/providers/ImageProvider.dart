import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/fire_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class ImgProvider with ChangeNotifier {
  List<Map<String, dynamic>> _selectedList = [];
  List<Map<String, dynamic>> get selectedList => _selectedList;

  late Future<List<Map<String, dynamic>>> _imageList;
  Future<List<Map<String, dynamic>>> get imageList => _imageList;
  void fetchImageList() {
    notifyListeners();
    _imageList = FireStorage().getImageList();
  }

  void addSelectImage(Map<String, dynamic> image) {
    notifyListeners();
    _selectedList.add(image);
  }

  void removeSelectImage(Map<String, dynamic> image) {
    notifyListeners();
    _selectedList.remove(image);
  }

  void deleteSelectedImage() async {
    notifyListeners();
    for (var i = 0; i < _selectedList.length; i++) {
      FireStorage().deleteImage(_selectedList[i]['path']);
    }
    _selectedList = [];
  }

  void saveSelectedImage() async {
    notifyListeners();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    File downloadToFile = File(
        '${appDocDir.path}/beepees-${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now())}.png');
    try {
      for (var i = 0; i < _selectedList.length; i++) {
        await firebase_storage.FirebaseStorage.instance
            .ref(_selectedList[i]['path'])
            .writeToFile(downloadToFile);
      }
      _selectedList = [];
      fetchImageList();
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }
}
