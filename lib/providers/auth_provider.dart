import 'package:flutter/cupertino.dart';

import 'package:locallinker/services/auth_service.dart';

enum AuthStatus { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setErrorMessage(String? message) {
    _errorMessage = message;
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _setErrorMessage(null);

    final user = await _authService.signInWithEmailAndPassword(email, password);

    _setLoading(false);
    if (user == null) {
      _setErrorMessage('Failed to sign in. Please check your credentials.');
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> signUp(String name, String email, String password) async {
    _setLoading(true);
    _setErrorMessage(null);

    final user = await _authService.signUpWithEmailAndPassword(name, email, password);

    _setLoading(false);
    if (user == null) {
      _setErrorMessage('Failed to sign up. The email might already be in use.');
      notifyListeners();
      return false;
    }
    return true;
  }

  Future<bool> sendPasswordResetEmail(String email) async {
    _setLoading(true);
    _setErrorMessage(null);

    try {
      await _authService.sendPasswordResetEmail(email);
      _setLoading(false);
      return true;
    } catch (e) {
      _setErrorMessage('Failed to send reset link. Please try again.');
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    notifyListeners();
  }
}