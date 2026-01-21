import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/core/i10n/locale_view_model.dart';
import 'package:flutter_template/core/theme/theme_view_model.dart';
import 'package:flutter_template/features/counter/repository/counter_repository.dart';
import 'package:flutter_template/features/counter/view_model/counter_view_model.dart';
import 'package:flutter_template/generated/l10n.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

class MockGetStorage extends Mock implements GetStorage {}

Future<void> pumpApp(
  WidgetTester tester,
  Widget child, {
  ThemeController? themeController,
  LocaleViewModel? localeController,
  CounterViewModel? counterController,
  CounterRepository? counterRepository,
}) async {
  await tester.pumpWidget(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value:
              themeController ?? ThemeController(MockGetStorage())
                ..loadThemeMode(),
        ),
        ChangeNotifierProvider.value(
          value:
              localeController ?? LocaleViewModel(MockGetStorage())
                ..loadLocale(),
        ),
        ChangeNotifierProvider(
          create:
              (_) =>
                  counterController ??
                        CounterViewModel(
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
