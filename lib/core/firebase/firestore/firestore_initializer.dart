import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreInitializer {
  static Future<void> setup({bool useEmulator = false}) async {
    if (useEmulator) {
      const host = 'localhost';
      FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
    }
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
    );
  }
}
