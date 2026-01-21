import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/theme_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late ThemeController controller;
  late GetStorage storage;

  setUp(() {
    storage = MockGetStorage();
    when(() => storage.write(any(), any())).thenAnswer((_) async {});
    when(() => storage.read(any())).thenReturn(null);
    when(() => storage.remove(any())).thenAnswer((_) async {});

    controller = ThemeController(storage);
  });

  test('initial themeMode is system', () {
    expect(controller.themeMode, equals(ThemeMode.system));
  });

  test('setThemeMode updates value', () {
    controller.setThemeMode(ThemeMode.dark);
    expect(controller.themeMode, ThemeMode.dark);

    controller.setThemeMode(ThemeMode.light);
    expect(controller.themeMode, ThemeMode.light);
  });

  test('toggleTheme switches between light and dark', () {
    controller.setThemeMode(ThemeMode.light);
    controller.toggleTheme();

    expect(controller.themeMode, ThemeMode.dark);

    controller.toggleTheme();
    expect(controller.themeMode, ThemeMode.light);
  });

  test('loadThemeMode restores persisted mode', () async {
    when(() => storage.read<bool>(any())).thenReturn(true);

    await controller.loadThemeMode();
    expect(controller.themeMode, ThemeMode.dark);
  });

  test('notifies listeners on change', () async {
    int notifyCount = 0;
    controller.addListener(() => notifyCount++);

    controller.setThemeMode(ThemeMode.dark);
    controller.toggleTheme();

    expect(notifyCount, greaterThan(0));
  });
}
