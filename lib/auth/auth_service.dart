import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, e.message ?? "An unknown error occurred.");
      return null;
    }
  }

  // Sign up with email and password
  Future<UserCredential?> signUpWithEmailPassword(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, e.message ?? "An unknown error occurred.");
      return null;
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email, BuildContext context) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      _showInfoDialog(context, "Password Reset Email Sent", "Please check your inbox to reset your password.");
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(context, e.message ?? "An unknown error occurred.");
    }
  }

  // Helper method to show an error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Authentication Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  // Helper method to show a generic info dialog
  void _showInfoDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }
}