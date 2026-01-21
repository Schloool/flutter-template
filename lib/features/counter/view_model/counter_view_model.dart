import 'package:flutter_template/features/counter/model/counter_model.dart';
import 'package:flutter_template/features/counter/repository/counter_repository.dart';
import 'package:flutter_template/shared/base_view_model.dart';

class CounterViewModel extends BaseViewModel<CounterModel> {
  CounterViewModel(this._repository);

  final CounterRepository _repository;

  Future<void> loadInitialCount() async {
    setLoading(true);

    final initialCount = await _repository.getInitialCount();
    setData(CounterModel(initialCount), notify: false);

    setLoading(false);
  }

  void increment() {
    if (data == null) return;

    setData(data!.increment());
  }
}
