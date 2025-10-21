import 'package:flutter_template/features/counter/service/counter_service.dart';

import 'counter_repository.dart';

class LocalCounterRepository implements CounterRepository {
  LocalCounterRepository(this._service);

  final CounterService _service;

  @override
  Future<int> getInitialCount() {
    return _service.fetchInitialCount();
  }
}
