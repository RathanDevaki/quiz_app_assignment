import 'package:flutter/material.dart';

class AuthenticProvider extends ChangeNotifier {
  bool isLogged = false;
  void logCheck(bool _isLogged) {
    isLogged = _isLogged;
    notifyListeners();
  }
}
