import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/root_screen.dart'; // Update this import

void main() => runApp(const SocialApp());

class SocialApp extends StatelessWidget {
  const SocialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0A0A),
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
        ),
      ),
      home: const RootScreen(), // Point home to the new RootScreen
    );
  }
}