import 'package:flutter/cupertino.dart';
import 'package:flutter_template/features/counter/model/counter_model.dart';
import 'package:flutter_template/features/counter/repository/counter_repository.dart';

class CounterController extends ChangeNotifier {
  CounterController(this._repository);

  final CounterRepository _repository;
  CounterModel? _model;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  int get count => _model?.count ?? 0;

  Future<void> loadInitialCount() async {
    _isLoading = true;
    notifyListeners();

    final initialCount = await _repository.getInitialCount();
    _model = CounterModel(initialCount);

    _isLoading = false;
    notifyListeners();
  }

  void increment() {
    if (_model == null) return;

    _model = _model!.increment();
    notifyListeners();
  }
}
