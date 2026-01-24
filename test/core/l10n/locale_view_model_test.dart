import 'package:flutter/material.dart';
import 'package:flutter_template/core/i10n/locale_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late LocaleViewModel viewModel;
  late GetStorage storage;

  setUp(() {
    storage = MockGetStorage();

    when(() => storage.write(any(), any())).thenAnswer((_) async {});
    when(() => storage.read<String>(any())).thenReturn(null);
    when(() => storage.remove(any())).thenAnswer((_) async {});

    viewModel = LocaleViewModel(storage);
  });

  test('initial locale is loaded from default', () {
    viewModel.loadLocale();

    expect(viewModel.locale?.languageCode, LocaleViewModel.defaultLocaleCode);
  });

  test('setLocale updates locale', () async {
    viewModel.setLocale(const Locale('en'));
    expect(viewModel.locale, const Locale('en'));

    viewModel.setLocale(const Locale('de'));
    expect(viewModel.locale, const Locale('de'));
  });

  test('loadLocale restores persisted locale', () async {
    when(() => storage.read<String>(any())).thenReturn('de');

    await viewModel.loadLocale();

    expect(viewModel.locale, const Locale('de'));
  });

  test('clearLocale removes value', () async {
    viewModel.setLocale(const Locale('de'));

    viewModel.clearLocale();

    expect(viewModel.locale, isNull);
  });

  test('toggleLocale switches between en and de', () async {
    viewModel.setLocale(const Locale('en'));
    viewModel.toggleLocale();
    expect(viewModel.locale, const Locale('de'));

    viewModel.toggleLocale();
    expect(viewModel.locale, const Locale('en'));
  });

  test('notifies listeners on change', () {
    int count = 0;
    viewModel.addListener(() => count++);

    viewModel.setLocale(const Locale('en'));
    viewModel.toggleLocale();
    viewModel.clearLocale();

    expect(count, greaterThan(0));
  });
}
