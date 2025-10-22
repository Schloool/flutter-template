import 'package:flutter_template/features/counter/model/counter_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CounterModel increment increases count by 1', () {
    final model = CounterModel(0);

    final incremented = model.increment();

    expect(incremented.count, 1);
    expect(incremented, isNot(same(model)));
  });
}
