import 'package:flutter/material.dart';

final ThemeData coffeeTheme = ThemeData(
  scaffoldBackgroundColor: const Color(0xFFF6EFEA), // Background
  primaryColor: const Color(0xFFA47148), // Accent
  cardColor: const Color(0xFFF1E6D8), // Card background
  iconTheme: const IconThemeData(color: Color(0xFF6E4B32)), // Icon color

  textTheme: const TextTheme(
    titleMedium: TextStyle(color: Color(0xFF2E1C13), fontWeight: FontWeight.bold, fontSize: 18),
    bodyMedium: TextStyle(color: Color(0xFF8E7D72), fontSize: 14),
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF6EFEA),
    foregroundColor: Color(0xFF2E1C13),
    elevation: 0,
    iconTheme: IconThemeData(color: Color(0xFF6E4B32)),
  ),

  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: const Color(0xFFA47148), // For FAB, accent buttons
  ),
);
