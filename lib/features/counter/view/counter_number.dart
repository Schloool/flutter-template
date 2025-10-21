import 'package:flutter/material.dart';

class CounterNumber extends StatelessWidget {
  const CounterNumber({required this.value, super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Text(
      value.toString(),
      style: Theme.of(context).textTheme.headlineLarge,
    );
  }
}
