import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'auth_service.dart';

class AuthNotifier extends ChangeNotifier {
  final AuthService _authService;
  late final StreamSubscription<User?> _sub;

  AuthNotifier(this._authService) {
    _sub = _authService.authStateChanges().listen((_) => notifyListeners());
  }

  bool get isLoggedIn => _authService.currentUser != null;

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }
}
