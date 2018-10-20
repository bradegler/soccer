
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const MaterialColor primarySwatch = Colors.brown;
  static const MaterialColor accentSwatch = Colors.green;
  static Color primary = primarySwatch.shade800;
  static Color accent = accentSwatch.shade500;
  static Color highlight = Colors.deepPurple.shade600;

  final ThemeData themeData = ThemeData(
    primarySwatch: primarySwatch,
    accentColor: accent,
    primaryColor: primary,
    textTheme: Typography(platform: defaultTargetPlatform).white,
    highlightColor: highlight,
  );
  AppTheme();
}