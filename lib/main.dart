import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/theme_controller.dart';
import 'package:flutter_template/features/counter/repository/local_counter_repository.dart';
import 'package:flutter_template/features/counter/service/counter_service.dart';
import 'package:flutter_template/features/counter/view/counter_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/counter/controller/counter_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            return ThemeController()..loadThemeMode();
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            return CounterController(LocalCounterRepository(CounterService()))
              ..loadInitialCount();
          },
        ),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  static const String appName = 'Flutter Template';

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    return MaterialApp(
      title: appName,
      themeMode: themeController.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const CounterScreen(),
    );
  }
}
