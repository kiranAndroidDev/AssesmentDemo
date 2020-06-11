import 'package:flutter/material.dart';

const Color primary = Colors.white;
const Color primaryDark = Colors.white;
const Color accent = Colors.blue;
const Color blueDark = Color(0xff000080);
class AppTheme {
  static ThemeData getThemeData(BuildContext context) {
    return Theme.of(context).copyWith(
        primaryColor: primary,
        accentColor: accent,
        splashColor: primary,
        scaffoldBackgroundColor: Colors.white,
        bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black54)
    );
  }
}