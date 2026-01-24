import 'package:flutter/material.dart';
import 'package:flutter_template/app.dart';
import 'package:flutter_template/core/firebase/auth/service/firebase_auth_service.dart';
import 'package:flutter_template/core/firebase/auth/view_model/auth_view_model.dart';
import 'package:flutter_template/core/firebase/firebase_initializer.dart';
import 'package:flutter_template/core/firebase/firestore/firestore_initializer.dart';
import 'package:flutter_template/core/i10n/locale_view_model.dart';
import 'package:flutter_template/core/theme/theme_view_model.dart';
import 'package:flutter_template/features/counter/repository/local_counter_repository.dart';
import 'package:flutter_template/features/counter/service/counter_service.dart';
import 'package:flutter_template/features/counter/view_model/counter_view_model.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  final firebaseApp = await FirebaseInitializer.init(enable: true);

  if (firebaseApp != null) {
    await FirestoreInitializer.setup(useEmulator: true);
  }

  final getStorage = GetStorage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<FirebaseAuthViewModel>(
          create: (_) {
            return FirebaseAuthViewModel(FirebaseAuthService());
          },
        ),
        ChangeNotifierProvider<ThemeViewModel>(
          create: (_) {
            return ThemeViewModel(getStorage)..loadThemeMode();
          },
        ),
        ChangeNotifierProvider<LocaleViewModel>(
          create: (_) {
            return LocaleViewModel(getStorage)..loadLocale();
          },
        ),

        ChangeNotifierProvider<CounterViewModel>(
          create: (_) {
            return CounterViewModel(LocalCounterRepository(CounterService()))
              ..loadInitialCount();
          },
        ),
      ],
      child: const App(),
    ),
  );
}
