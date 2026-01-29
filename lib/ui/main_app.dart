import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/home_screen.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kanbellon',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Slightly lighter than black
      ),
      theme: ThemeData(
         useMaterial3: true,
         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
         textTheme: GoogleFonts.outfitTextTheme(),
      ),
      home: const HomeScreen(),
    );
  }
}
