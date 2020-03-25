import 'package:dualarim/util/dark_mode_preference.dart';
import 'package:flutter/material.dart';

class DarkModeProvider with ChangeNotifier {
  DarkModePreference darkThemePreference = DarkModePreference();
  bool _darkMode = false;

  bool get darkMode => _darkMode;

  set darkMode(bool value) {
    _darkMode = value;
    darkThemePreference.setDarkMode(value);
    notifyListeners();
  }
}
