import 'dart:io';

import 'package:connect_four/utils/color.util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConnectFourTheme {
  static ThemeData get light {
    return _getTheme(ColorUtil.primaryColor, isAndroid: Platform.isAndroid);
  }

  static ThemeData get dark {
    return _getTheme(ColorUtil.primaryColor, isLight: false, isAndroid: Platform.isAndroid);
  }

  static ThemeData _getTheme(MaterialColor color, {bool isLight = true, bool isAndroid = false}) {
    final theme = isLight ? ThemeData.light() : ThemeData.dark();

    return ThemeData(
      brightness: isLight ? Brightness.light : Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: color,
        brightness: isLight ? Brightness.light : Brightness.dark,
        secondary: isLight ? const Color(0xFFE5E5E5) : Colors.grey[500],
      ),
      primarySwatch: color,
      primaryColor: color,
      splashColor: isAndroid ? theme.splashColor : Colors.transparent,
      highlightColor: isAndroid ? theme.highlightColor : Colors.transparent,
      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: isLight ? Colors.black : Colors.white),
      ),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: theme.textTheme.copyWith(
        headline1: theme.textTheme.headline1?.copyWith(
          fontFamily: GoogleFonts.nothingYouCouldDo().fontFamily,
          fontWeight: FontWeight.bold,
          height: 1,
          fontSize: 80,
        ),
        headline6: TextStyle(fontWeight: FontWeight.bold, color: isLight ? Colors.black : Colors.white),
      ),
      buttonTheme: theme.buttonTheme.copyWith(
        buttonColor: color,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
