import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  String? _userName;
  String? get userName => _userName;

  void setUserName(String userName) {
    _userName = userName;
  }
}
