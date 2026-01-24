import 'package:flutter_template/features/counter/view/counter_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const CounterScreen()),
  ],
);
