import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeViewModel(this._storage);

  static const defaultTheme = ThemeMode.light;
  static const _isDarkModeKey = 'is_dark_mode';

  final GetStorage _storage;

  ThemeMode _themeMode = defaultTheme;

  ThemeMode get themeMode => _themeMode;

  Future<void> loadThemeMode() async {
    final isDarkMode = _storage.read<bool>(_isDarkModeKey);
    _themeMode =
        isDarkMode == null
            ? defaultTheme
            : (isDarkMode ? ThemeMode.dark : ThemeMode.light);

    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();

    _storage.write(_isDarkModeKey, mode == ThemeMode.dark);
  }

  void toggleTheme() {
    if (_themeMode == ThemeMode.light) {
      setThemeMode(ThemeMode.dark);
      return;
    }

    setThemeMode(ThemeMode.light);
  }
}
