import 'package:flutter_template/features/counter/controller/counter_controller.dart';
import 'package:flutter_template/features/counter/repository/counter_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late CounterController controller;
  late MockCounterRepository repository;

  setUp(() {
    repository = MockCounterRepository();
    controller = CounterController(repository);
  });

  test('loadInitialCount loads initial value and updates isLoading', () async {
    when(() => repository.getInitialCount()).thenAnswer((_) async => 5);

    final states = <bool>[];
    controller.addListener(() => states.add(controller.isLoading));

    await controller.loadInitialCount();

    expect(controller.count, 5);
    expect(states, [true, false]);
  });

  test('increment increases count', () async {
    when(() => repository.getInitialCount()).thenAnswer((_) async => 0);
    await controller.loadInitialCount();

    controller.increment();

    expect(controller.count, 1);
  });
}
