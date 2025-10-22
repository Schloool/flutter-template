import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/core/i10n/locale_controller.dart';
import 'package:flutter_template/core/theme/theme_controller.dart';
import 'package:flutter_template/features/counter/controller/counter_controller.dart';
import 'package:flutter_template/features/counter/repository/counter_repository.dart';
import 'package:flutter_template/generated/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  ThemeController? themeController,
  LocaleController? localeController,
  CounterController? counterController,
  CounterRepository? counterRepository,
}) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value:
              themeController ?? ThemeController()
                ..loadThemeMode(),
        ),
        ChangeNotifierProvider.value(
          value:
              localeController ?? LocaleController()
                ..loadLocale(),
        ),
        ChangeNotifierProvider(
          create:
              (_) =>
                  counterController ??
                        CounterController(
                          counterRepository ?? FakeCounterRepository()
                            ..getInitialCount(),
                        )
                    ..loadInitialCount(),
        ),
      ],
      child: MaterialApp(
        locale: const Locale('en'),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: child,
      ),
    ),
  );

  await tester.pumpAndSettle();
}

class FakeCounterRepository implements CounterRepository {
  @override
  Future<int> getInitialCount() async => 0;
}
