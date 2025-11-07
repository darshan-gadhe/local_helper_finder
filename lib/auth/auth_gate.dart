import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locallinker/auth/login_screen.dart';
import 'package:locallinker/screens/main_screen_wrapper.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is logged in
          if (snapshot.hasData) {
            return const MainScreenWrapper();
          }
          // User is NOT logged in
          else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}