import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _common = ThemeData(primaryColor: Colors.blue);

  static final ThemeData lightTheme = _common.copyWith(
    colorScheme: const ColorScheme.light(primary: Colors.blue),
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: _common.primaryColor,
    colorScheme: const ColorScheme.dark(primary: Colors.blue),
  );
}
