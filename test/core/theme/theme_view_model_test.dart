import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/theme_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late ThemeViewModel viewModel;
  late GetStorage storage;

  setUp(() {
    storage = MockGetStorage();
    when(() => storage.write(any(), any())).thenAnswer((_) async {});
    when(() => storage.read(any())).thenReturn(null);
    when(() => storage.remove(any())).thenAnswer((_) async {});

    viewModel = ThemeViewModel(storage);
  });

  test('initial themeMode is loaded from default', () {
    expect(viewModel.themeMode, equals(ThemeViewModel.defaultTheme));
  });

  test('setThemeMode updates value', () {
    viewModel.setThemeMode(ThemeMode.dark);
    expect(viewModel.themeMode, ThemeMode.dark);

    viewModel.setThemeMode(ThemeMode.light);
    expect(viewModel.themeMode, ThemeMode.light);
  });

  test('toggleTheme switches between light and dark', () {
    viewModel.setThemeMode(ThemeMode.light);
    viewModel.toggleTheme();

    expect(viewModel.themeMode, ThemeMode.dark);

    viewModel.toggleTheme();
    expect(viewModel.themeMode, ThemeMode.light);
  });

  test('loadThemeMode restores persisted mode', () async {
    when(() => storage.read<bool>(any())).thenReturn(true);

    await viewModel.loadThemeMode();
    expect(viewModel.themeMode, ThemeMode.dark);
  });

  test('notifies listeners on change', () async {
    int notifyCount = 0;
    viewModel.addListener(() => notifyCount++);

    viewModel.setThemeMode(ThemeMode.dark);
    viewModel.toggleTheme();

    expect(notifyCount, greaterThan(0));
  });
}
