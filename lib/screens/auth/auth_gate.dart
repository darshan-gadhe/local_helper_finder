import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:locallinker/providers/user_provider.dart';
import 'package:locallinker/screens/auth/login_screen.dart';
import 'package:locallinker/screens/main_screen_wrapper.dart';
import 'package:provider/provider.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        // User is not logged in
        if (!snapshot.hasData) {
          // --- THIS IS THE FIX ---
          // Schedule the `clearUser` call to happen after the build is complete.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<UserProvider>(context, listen: false).clearUser();
          });
          return const LoginScreen();
        }

        // User is logged in, fetch their data
        final user = snapshot.data;
        if (user != null) {
          // It's safe to call `fetchUserData` here because it's an async operation
          // and its `notifyListeners` will be called later, not during this build.
          Provider.of<UserProvider>(context, listen: false).fetchUserData(user.uid);
          return const MainScreenWrapper();
        }

        // Fallback to login screen
        return const LoginScreen();
      },
    );
  }
}