import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  /// [fontSize: 50, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle heading50({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 50,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 35, FontWeight.w400, Colors.black, letterSpacing: -.5]
  static TextStyle heading35({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = -.5,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 35,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 30, FontWeight.w400, Colors.black, letterSpacing: 0]
  static TextStyle heading30({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 30,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 28, FontWeight.w400, Colors.black, letterSpacing: 0]
  static TextStyle heading28({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w400,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 28,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 26, FontWeight.w700, Colors.black, letterSpacing: -.24]
  static TextStyle heading26({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = -.24,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 26,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 24, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle heading24({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 24,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 22, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle heading22({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 22,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 20, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle heading20({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 20,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 18, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle bodyLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 18,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 16, FontWeight.w700, Colors.black, letterSpacing: 0]
  static TextStyle bodyMedium({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 16,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 14, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle bodySmall({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 14,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 12, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle bodyXSmall({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 12,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 10, FontWeight.w500, Colors.black, letterSpacing: 0]
  static TextStyle bodyCaption({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w500,
    double letterSpacing = 0,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 10,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: letterSpacing,
      );

  /// [fontSize: 200, FontWeight.w500, Colors.black]
  static TextStyle headingLarge({
    Color color = Colors.black,
    FontWeight fontWeight = FontWeight.w200,
  }) =>
      GoogleFonts.sourceSansPro(
        fontSize: 110,
        fontWeight: fontWeight,
        color: color,
      );

  /// [fontSize: 300, FontWeight.w700, Colors.white, letterSpacing: 0.1]
  static TextStyle bodyExtraLarge({
    Color color = Colors.white,
    FontWeight fontWeight = FontWeight.w700,
    double letterSpacing = 0.1,
    double colorOpacity = 0.1,
  }) =>
      GoogleFonts.sourceSansPro(
        fontWeight: fontWeight,
        color: color.withOpacity(colorOpacity),
        letterSpacing: letterSpacing,
      );
}
