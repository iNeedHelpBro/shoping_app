import 'package:flutter/material.dart';
import 'dark.dart';
import 'light.dart';

class ThemeProvider extends ChangeNotifier {
  static ThemeData _themeData = lightMode;

  ThemeData get mythemedata => _themeData;

  static bool get isDarkmode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void switchMode() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
