import 'package:flutter/material.dart';
import 'package:flutter_template/core/i10n/locale_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockGetStorage extends Mock implements GetStorage {}

void main() {
  late LocaleViewModel controller;
  late GetStorage storage;

  setUp(() {
    storage = MockGetStorage();

    when(() => storage.write(any(), any())).thenAnswer((_) async {});
    when(() => storage.read<String>(any())).thenReturn(null);
    when(() => storage.remove(any())).thenAnswer((_) async {});

    controller = LocaleViewModel(storage);
  });

  test('initial locale is null (system default)', () {
    expect(controller.locale, isNull);
  });

  test('setLocale updates locale', () async {
    controller.setLocale(const Locale('en'));
    expect(controller.locale, const Locale('en'));

    controller.setLocale(const Locale('de'));
    expect(controller.locale, const Locale('de'));
  });

  test('loadLocale restores persisted locale', () async {
    when(() => storage.read<String>(any())).thenReturn('de');

    await controller.loadLocale();

    expect(controller.locale, const Locale('de'));
  });

  test('clearLocale removes value', () async {
    controller.setLocale(const Locale('de'));

    controller.clearLocale();

    expect(controller.locale, isNull);
  });

  test('toggleLocale switches between en and de', () async {
    controller.setLocale(const Locale('en'));
    controller.toggleLocale();
    expect(controller.locale, const Locale('de'));

    controller.toggleLocale();
    expect(controller.locale, const Locale('en'));
  });

  test('notifies listeners on change', () {
    int count = 0;
    controller.addListener(() => count++);

    controller.setLocale(const Locale('en'));
    controller.toggleLocale();
    controller.clearLocale();

    expect(count, greaterThan(0));
  });
}
