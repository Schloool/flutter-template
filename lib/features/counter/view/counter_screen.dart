import 'package:flutter/material.dart';
import 'package:flutter_template/features/counter/controller/counter_controller.dart';
import 'package:flutter_template/features/counter/view/counter_number.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CounterController>();

    if (controller.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Center(child: CounterNumber(value: controller.count)),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
