import 'package:flutter/material.dart';
import 'package:flutter_template/features/counter/repository/local_counter_repository.dart';
import 'package:flutter_template/features/counter/service/counter_service.dart';
import 'package:flutter_template/features/counter/view/counter_screen.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'features/counter/controller/counter_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: const CounterScreen(),
    );
  }
}
