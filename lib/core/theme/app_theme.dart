import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _common = ThemeData(
    primaryColor: Colors.blue,
    useMaterial3: true,
  );

  static final ThemeData lightTheme = _common.copyWith(
    colorScheme: const ColorScheme.light(),
  );

  static final ThemeData darkTheme = _common.copyWith(
    colorScheme: const ColorScheme.dark(),
  );
}
