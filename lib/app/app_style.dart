import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  // App Images ..
  static const String profile = "assets/images/profile.jpg";
  /// App Icons.
  static const String notificationsIcon = "assets/icons/notifications.svg";
  static const String profileIcon = "assets/icons/profile.svg";
// App Colors
  static const primarySwatch = Color(0xff1C6BA4);
  static const inputFillColor = Color(0xffEEF6FC);
//Dr images
  // App Theme Data..
  static ThemeData? theme = ThemeData(
    textTheme: GoogleFonts.nunitoSansTextTheme().apply(
      bodyColor: const Color(0xff0E1012),
      displayColor: const Color(0xff0E1012),
    ),
  );
}
