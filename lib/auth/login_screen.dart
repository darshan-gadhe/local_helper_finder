import 'package:flutter/material.dart';
import 'package:locallinker/screens/main_screen_wrapper.dart';
import 'package:locallinker/widgets/search_bar_widget.dart'; // We can reuse this style

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;

  void _navigateToHome() {
    // This is the crucial part. 
    // pushReplacement removes the login screen from the navigation stack,
    // so the user can't press 'back' to return to it after logging in.
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const MainScreenWrapper()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          children: [
            // Header Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.link, size: 48, color: Colors.blueAccent),
                const SizedBox(height: 16),
                Text(
                  "Welcome Back,",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Login to your Locallinker account.",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey[400]),
                ),
              ],
            ),
            const SizedBox(height: 48),

            // Form Section
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: "Email or Phone Number",
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                labelText: "Password",
                filled: true,
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Forgot Password
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: const Text("Forgot Password?"),
              ),
            ),
            const SizedBox(height: 24),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _navigateToHome, // Navigate on press
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                child: const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 32),

            // "OR" Divider
            Row(
              children: const [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text("OR", style: TextStyle(color: Colors.grey)),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 32),

            // Sign Up Option
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?", style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () {
                    // Navigate to a SignUp screen (which you would create)
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}