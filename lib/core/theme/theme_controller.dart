import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends ChangeNotifier {
  static const isDarkModeKey = 'is_dark_mode';

  final _storage = GetStorage();

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadThemeMode() async {
    final isDarkMode = _storage.read<bool>(isDarkModeKey);
    _themeMode =
        isDarkMode == null
            ? ThemeMode.system
            : (isDarkMode ? ThemeMode.dark : ThemeMode.light);

    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();

    _storage.write(isDarkModeKey, mode == ThemeMode.dark);
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
      return;
    }

    setThemeMode(ThemeMode.light);
  }
}
