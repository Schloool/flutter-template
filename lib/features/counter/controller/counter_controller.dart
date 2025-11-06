import 'package:flutter_template/features/counter/model/counter_model.dart';
import 'package:flutter_template/features/counter/repository/counter_repository.dart';
import 'package:flutter_template/shared/base_controller.dart';

class CounterController extends BaseController<CounterModel> {
  CounterController(this._repository);

  final CounterRepository _repository;

  Future<void> loadInitialCount() async {
    setLoading(true, notify: true);

    final initialCount = await _repository.getInitialCount();
    setData(CounterModel(initialCount));

    setLoading(false, notify: true);
  }

  void increment() {
    if (data == null) return;

    setData(data!.increment(), notify: true);
  }
}
