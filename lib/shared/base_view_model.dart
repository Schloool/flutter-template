import 'package:flutter/foundation.dart';

abstract class BaseViewModel<T> extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  T? _data;

  bool get isLoading => _isLoading;
  String? get error => _error;
  T? get data => _data;

  void setLoading(bool value, {bool notify = true}) {
    _isLoading = value;

    if (notify) {
      notifyListeners();
    }
  }

  void setError(String? value, {bool notify = true}) {
    _error = value;

    if (notify) {
      notifyListeners();
    }
  }

  void setData(T? value, {bool notify = true}) {
    _data = value;

    if (notify) {
      notifyListeners();
    }
  }
}
