import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:locallinker/providers/auth_provider.dart';
import 'package:locallinker/providers/booking_provider.dart';
import 'package:locallinker/providers/location_provider.dart';
import 'package:locallinker/providers/theme_provider.dart'; // <-- IMPORT THEME PROVIDER
import 'package:locallinker/providers/user_provider.dart';
import 'package:locallinker/screens/auth/auth_gate.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // USE MULTIPROVIDER FOR BOTH AUTH AND THEME
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),    // <-- ADD THIS
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => BookingProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Locallinker',
            debugShowCheckedModeBanner: false,

            // --- THEME CONFIGURATION ---
            themeMode: themeProvider.themeMode, // Controlled by provider

            // Light Theme
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: const Color(0xFF1976D2), // A nice blue for light mode
                scaffoldBackgroundColor: const Color(0xFFF5F5F5),
                textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
                cardColor: Colors.white,
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  backgroundColor: Colors.white,
                  selectedItemColor: Color(0xFF1976D2),
                  unselectedItemColor: Colors.grey,
                  type: BottomNavigationBarType.fixed,
                ),
                appBarTheme: const AppBarTheme(
                  backgroundColor: Color(0xFFF5F5F5),
                  elevation: 0,
                  foregroundColor: Colors.black, // Icons and text color
                )
            ),

            // Dark Theme (your original theme)
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF0D47A1),
              scaffoldBackgroundColor: const Color(0xFF121212),
              textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
              cardColor: const Color(0xFF1E1E1E),
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                backgroundColor: Color(0xFF1E1E1E),
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
              ),
            ),

            home: const AuthGate(),
          );
        },
      ),
    );
  }
}