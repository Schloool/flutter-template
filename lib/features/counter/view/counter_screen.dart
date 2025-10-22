import 'package:flutter/material.dart';
import 'package:flutter_template/core/i10n/locale_controller.dart';
import 'package:flutter_template/core/theme/theme_controller.dart';
import 'package:flutter_template/features/counter/controller/counter_controller.dart';
import 'package:flutter_template/features/counter/view/counter_number.dart';
import 'package:flutter_template/generated/l10n.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = context.watch<CounterController>();
    final theme = context.watch<ThemeController>();

    return Scaffold(
      body: Center(
        child:
            counter.isLoading
                ? const CircularProgressIndicator()
                : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CounterNumber(value: counter.count),
                    const SizedBox(height: 20.0),
                    Text(S.of(context).appTitle),
                  ],
                ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!counter.isLoading) ...[
            FloatingActionButton(
              onPressed: counter.increment,
              child: const Icon(Icons.add),
            ),
            const SizedBox(width: 20),
          ],
          FloatingActionButton(
            onPressed: theme.toggleTheme,
            child: Icon(
              theme.themeMode == ThemeMode.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
          const SizedBox(width: 20),
          FloatingActionButton(
            onPressed: context.read<LocaleController>().toggleLocale,
            child: const Icon(Icons.language),
          ),
        ],
      ),
    );
  }
}
