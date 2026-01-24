import 'package:flutter_template/features/counter/repository/counter_repository.dart';
import 'package:flutter_template/features/counter/view_model/counter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterRepository extends Mock implements CounterRepository {}

void main() {
  late CounterViewModel viewModel;
  late MockCounterRepository repository;

  setUp(() {
    repository = MockCounterRepository();
    viewModel = CounterViewModel(repository);
  });

  test('loadInitialCount loads initial value and updates isLoading', () async {
    when(() => repository.getInitialCount()).thenAnswer((_) async => 5);

    final states = <bool>[];
    viewModel.addListener(() => states.add(viewModel.isLoading));

    await viewModel.loadInitialCount();

    expect(viewModel.data?.value, 5);
    expect(states, [true, false]);
  });

  test('increment increases count', () async {
    when(() => repository.getInitialCount()).thenAnswer((_) async => 0);
    await viewModel.loadInitialCount();

    viewModel.increment();

    expect(viewModel.data?.value, 1);
  });
}
