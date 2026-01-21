import 'package:flutter/material.dart';
import 'package:flutter_template/features/counter/view/counter_screen.dart';
import 'package:flutter_template/features/counter/view_model/counter_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../util/mock_helpers.dart';

void main() {
  late CounterViewModel controller;

  setUp(() async {
    controller = CounterViewModel(FakeCounterRepository());
    await controller.loadInitialCount();
  });

  testWidgets('CounterScreen displays initial count and FABs', (tester) async {
    await pumpApp(tester, const CounterScreen(), counterController: controller);
    await tester.pumpAndSettle();

    expect(find.text('0'), findsOneWidget);

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
    expect(find.byIcon(Icons.language), findsOneWidget);
  });

  testWidgets('Increment button increases count', (tester) async {
    await pumpApp(tester, const CounterScreen(), counterController: controller);
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
