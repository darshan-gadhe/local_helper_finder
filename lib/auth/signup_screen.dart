import 'package:flutter/material.dart';
import 'package:locallinker/auth/auth_service.dart';
import 'package:locallinker/auth/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  void _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match!")),
      );
      return;
    }
    setState(() => _isLoading = true);
    await _authService.signUpWithEmailPassword(
      _emailController.text.trim(),
      _passwordController.text.trim(),
      context,
    );
    if(mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add_alt_1, size: 80),
              const SizedBox(height: 24),
              const Text("Create Account", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("Fill in the details to get started", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 40),

              // Fields
              TextField(controller: _emailController, decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 16),
              TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 16),
              TextField(controller: _confirmPasswordController, obscureText: true, decoration: InputDecoration(labelText: "Confirm Password", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 24),

              // Sign Up Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _signUp,
                  style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: _isLoading ? const CircularProgressIndicator(color: Colors.white) : const Text("Sign Up"),
                ),
              ),
              const SizedBox(height: 24),

              // Login now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member? "),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
                    child: const Text("Login now", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}