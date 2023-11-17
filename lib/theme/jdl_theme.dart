import 'package:flutter/material.dart';

class JDLTheme {
  static ThemeData theme({Color seedColor = const Color(0xff6750A4)}) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(seedColor: seedColor, brightness: Brightness.dark);

    return ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: colorScheme.surface,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.outlineVariant),
            borderRadius: BorderRadius.circular(4.0),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: colorScheme.outlineVariant),
          ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity);
  }
}
