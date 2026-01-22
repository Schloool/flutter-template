import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/core/firebase/auth/service/auth_service.dart';

import '../../../../shared/logger.dart';

class FirebaseAuthViewModel extends ChangeNotifier {
  FirebaseAuthViewModel(this._authService) {
    _listenToAuthChanges();
  }

  final AuthService _authService;

  bool? _isAuthenticated;
  User? _user;
  StreamSubscription<User?>? _sub;

  bool? get isAuthenticated => _isAuthenticated;
  User? get user => _user;

  void _listenToAuthChanges() {
    _sub = _authService.userChanges.listen((user) {
      _user = user;
      _isAuthenticated = user != null;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _authService.signInWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      logger.e('Sign in failed: ${e.message}');
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _authService.registerWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      logger.e('Register failed: ${e.message}');
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
