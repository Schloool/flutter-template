import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Stream<User?> get userChanges;
  Future<UserCredential> signInWithEmail(String email, String password);
  Future<UserCredential> registerWithEmail(String email, String password);
  Future<void> signOut();
}
