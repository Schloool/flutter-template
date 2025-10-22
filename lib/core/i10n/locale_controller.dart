import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocaleController extends ChangeNotifier {
  static const _langCodeKey = 'lang_code';
  final _storage = GetStorage();

  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> loadLocale() async {
    final savedLang = _storage.read<String>(_langCodeKey);

    if (savedLang != null && savedLang.isNotEmpty) {
      _locale = Locale(savedLang);
    } else {
      _locale = null;
    }

    notifyListeners();
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _storage.write(_langCodeKey, locale.languageCode);
    notifyListeners();
  }

  void clearLocale() {
    _locale = null;
    _storage.remove(_langCodeKey);
    notifyListeners();
  }

  void toggleLocale() {
    if (_locale?.languageCode == 'en') {
      setLocale(const Locale('de'));
    } else {
      setLocale(const Locale('en'));
    }
  }
}
