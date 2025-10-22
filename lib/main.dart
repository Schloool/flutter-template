import 'package:flutter/material.dart';
import 'package:flutter_template/core/theme/theme_controller.dart';
import 'package:flutter_template/features/counter/repository/local_counter_repository.dart';
import 'package:flutter_template/features/counter/service/counter_service.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'core/i10n/locale_controller.dart';
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
            return LocaleController()..loadLocale();
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
