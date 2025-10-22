import 'package:flutter/material.dart';
import 'package:flutter_template/core/i10n/locale_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';

// TODO: Fix mock GetStorage issue
void main() {
  late LocaleController controller;
  late GetStorage storage;

  setUp(() async {
    await GetStorage.init('locale_test');
    storage = GetStorage('locale_test');
    await storage.erase();
    controller = LocaleController();
  });

  test('initial locale is null (system default)', () {
    expect(controller.locale, isNull);
  });

  test('setLocale updates locale and persists it', () async {
    controller.setLocale(const Locale('en'));
    expect(controller.locale, const Locale('en'));
    expect(storage.read('lang_code'), equals('en'));

    controller.setLocale(const Locale('de'));
    expect(controller.locale, const Locale('de'));
    expect(storage.read('lang_code'), equals('de'));
  });

  test('loadLocale restores persisted locale', () async {
    await storage.write('lang_code', 'de');

    await controller.loadLocale();

    expect(controller.locale, const Locale('de'));
  });

  test('clearLocale removes saved value', () async {
    await storage.write('lang_code', 'en');
    controller.clearLocale();

    expect(controller.locale, isNull);
    expect(storage.read('lang_code'), isNull);
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
