import 'package:flutter/material.dart';
import 'package:flutter_template/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

// TODO: Fix mock GetStorage issue
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('app boots and increments counter', (tester) async {
    app.main();
    await tester.pumpAndSettle(const Duration(seconds: 4));

    final addButton = find.byIcon(Icons.add);
    expect(addButton, findsOneWidget);

    await tester.tap(addButton);
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
  });
}
