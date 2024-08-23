import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color inActiveBackgroundColor = Color(0xff757575);
const Color primaryColor = Color(0xff0e3f6c);
const Color subtitle1Color = Color(0xff3A3A3A);
const Color subtitle2Color = Color(0xff898A8D);

ThemeData theme() {
  return ThemeData(
      scaffoldBackgroundColor: const Color(0xfff4faff),
      primaryColor: primaryColor,
      textTheme: textTheme());
}

// All texts in the App should respect the specified text styles below. Only change The weight and the color if necessary.
TextTheme textTheme() {
  return TextTheme(
    // --------- App slogan ---------
    headline1: GoogleFonts.redHatDisplay(
      fontSize: 60.0,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),

    // --------- Titles ---------
    headline2: GoogleFonts.outfit(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      color: primaryColor,
    ),
    headline3: GoogleFonts.mulish(
      fontSize: 24,
      color: primaryColor,
      fontWeight: FontWeight.w800,
    ),
    headline4: GoogleFonts.poppins(
        fontSize: 18, color: Colors.black, fontWeight: FontWeight.w400),

    subtitle1: GoogleFonts.lato(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: subtitle1Color,
    ),
    subtitle2: GoogleFonts.mulish(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: subtitle2Color,
    ),

    // --------- Body Texts ---------
    bodyText1: GoogleFonts.openSans(fontSize: 18, color: Colors.black),
    bodyText2: GoogleFonts.openSans(fontSize: 14, color: Colors.black),

    // --------- Clickable Widgets ---------
    button: GoogleFonts.outfit(fontSize: 18, color: Colors.black),
  );
}
