import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/theme_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

// TODO: Fix mock GetStorage issue
void main() {
  late ThemeController controller;
  late GetStorage storage;

  setUp(() async {
    await GetStorage.init('test_storage');
    storage = GetStorage('test_storage');
    await storage.erase();
    controller = ThemeController();
  });

  test('initial themeMode is system', () {
    expect(controller.themeMode, equals(ThemeMode.system));
  });

  test('setThemeMode updates theme and persists value', () {
    controller.setThemeMode(ThemeMode.dark);

    expect(controller.themeMode, ThemeMode.dark);
    expect(storage.read(ThemeController.isDarkModeKey), isTrue);

    controller.setThemeMode(ThemeMode.light);

    expect(controller.themeMode, ThemeMode.light);
    expect(storage.read(ThemeController.isDarkModeKey), isFalse);
  });

  test('toggleTheme switches between light and dark', () async {
    controller.setThemeMode(ThemeMode.light);
    controller.toggleTheme();

    expect(controller.themeMode, ThemeMode.dark);

    controller.toggleTheme();
    expect(controller.themeMode, ThemeMode.light);
  });

  test('loadThemeMode restores persisted mode', () async {
    await storage.write(ThemeController.isDarkModeKey, true);

    await controller.loadThemeMode();
    expect(controller.themeMode, ThemeMode.dark);

    await storage.write(ThemeController.isDarkModeKey, false);
    await controller.loadThemeMode();
    expect(controller.themeMode, ThemeMode.light);
  });

  test('notifies listeners on change', () async {
    int notifyCount = 0;
    controller.addListener(() => notifyCount++);

    controller.setThemeMode(ThemeMode.dark);
    controller.toggleTheme();

    expect(notifyCount, greaterThan(0));
  });
}
