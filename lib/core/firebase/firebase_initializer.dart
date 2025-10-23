import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_template/core/util/logger.dart';

import 'firebase_options.dart';

class FirebaseInitializer {
  static Future<FirebaseApp?> init({bool enable = true}) async {
    if (!enable || DefaultFirebaseOptions.currentPlatform == null) {
      logger.w(
        'Firebase initialization skipped because corresponding platform was not found.',
      );
      return null;
    }

    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
