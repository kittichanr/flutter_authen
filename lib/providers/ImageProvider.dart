import 'package:flutter/material.dart';
import 'package:flutter_authen/modules/fire_storage.dart';

class ImgProvider with ChangeNotifier {
  List<Map<String, dynamic>> _selectedList = [];
  List<Map<String, dynamic>> get selectedList => _selectedList;

  late Future<List<Map<String, dynamic>>> _imageList;
  Future<List<Map<String, dynamic>>> get imageList => _imageList;
  void fetchImageList() {
    _imageList = FireStorage().getImageList();
  }

  void addSelectImage(Map<String, dynamic> image) {
    _selectedList.add(image);
  }

  void removeSelectImage(Map<String, dynamic> image) {
    _selectedList.remove(image);
  }
}
