import 'package:flutter_template/features/counter/repository/local_counter_repository.dart';
import 'package:flutter_template/features/counter/service/counter_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCounterService extends Mock implements CounterService {}

void main() {
  test('LocalCounterRepository delegates to CounterService', () async {
    final service = MockCounterService();
    when(() => service.fetchInitialCount()).thenAnswer((_) async => 10);

    final repo = LocalCounterRepository(service);

    expect(await repo.getInitialCount(), 10);
    verify(() => service.fetchInitialCount()).called(1);
  });
}
