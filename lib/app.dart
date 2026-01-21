import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template/core/i10n/locale_view_model.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'core/theme/theme_view_model.dart';
import 'features/counter/view/counter_screen.dart';
import 'generated/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  static const String appName = 'Flutter Template';

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final locale = context.watch<LocaleViewModel>();

    return MaterialApp(
      title: appName,
      themeMode: themeController.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      locale: locale.locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const CounterScreen(),
    );
  }
}
