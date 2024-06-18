import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme => _isDarkMode
      ? ThemeData.dark(useMaterial3: true)
      : ThemeData.light(useMaterial3: true);

  void setDarkMode() {
    _isDarkMode = true;
    notifyListeners();
  }

  void setLightMode() {
    _isDarkMode = false;
    notifyListeners();
  }
}
