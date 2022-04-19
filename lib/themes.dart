import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'constants.dart';

final mainDarkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.white,
  textTheme: TextTheme(
    bodyText2: TextStyle(fontFamily: fontFamilyTheme),
    bodyText1: TextStyle(fontFamily: fontFamilyTheme),
  ),
  appBarTheme: AppBarTheme(
      color: Colors.black,
      textTheme: TextTheme(
          headline6: TextStyle(
              fontFamily: fontFamilyTheme, fontSize: 20, color: Colors.white))),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
    textStyle: TextStyle(
        fontFamily: fontFamilyTheme, fontSize: 20, color: Colors.white),
    primary: Colors.black,
  )),
  textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
    textStyle: TextStyle(fontFamily: fontFamilyTheme, color: Colors.white),
    primary: Colors.black,
  )),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: Colors.white,
      fontFamily: fontFamilyTheme,
    ),
    hoverColor: Colors.white,
    errorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
    focusedErrorBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.red, width: 2)),
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2)),
    focusColor: Colors.white,
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(color: Colors.white)),
  ),
);

final mainLightTheme = ThemeData.light().copyWith(
  primaryColor: Colors.black,
  appBarTheme: AppBarTheme(
    color: Colors.white70,
    textTheme: TextTheme(
        headline6: TextStyle(
            fontFamily: fontFamilyTheme, fontSize: 20, color: Colors.black),
        bodyText1: TextStyle(
            fontFamily: fontFamilyTheme, fontSize: 20, color: Colors.black),
        button: TextStyle(
            fontFamily: fontFamilyTheme, fontSize: 20, color: Colors.black)),
  ),
);
