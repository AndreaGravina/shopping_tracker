import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart' as custom_colors;

ThemeData appTheme() {
  return ThemeData(
    scaffoldBackgroundColor: custom_colors.white,
    primaryColor: custom_colors.red,
    primaryColorDark: custom_colors.black,
    shadowColor: custom_colors.whiteSmoke,
    fontFamily: 'OpenSans',
    textTheme: _textTheme(),
    colorScheme: _colorScheme(),
    elevatedButtonTheme: _elevatedButtonThemeData(),
    //textSelectionTheme: _textSelectionTheme(),
    //inputDecorationTheme: _inputDecorationTheme(),
    //appBarTheme: _appBarTheme(),
    //cardTheme: _cardTheme(),
    //dialogTheme: _dialogTheme(),
  );
}

TextTheme _textTheme() {
  return const TextTheme(
    headline3: TextStyle(fontSize: 34.0),
    headline4: TextStyle(fontSize: 28.0),
    headline5: TextStyle(fontSize: 24.0),
    headline6: TextStyle(fontSize: 20.0),
    subtitle1: TextStyle(fontSize: 18.0),
    subtitle2: TextStyle(fontSize: 16.0),
    bodyText1: TextStyle(fontSize: 14.0),
    bodyText2: TextStyle(fontSize: 12.0),
  ).apply(
    bodyColor: custom_colors.black,
    displayColor: custom_colors.black,
  );
}

ColorScheme _colorScheme() {
  return const ColorScheme.light(
    primary: custom_colors.black,
    secondary: custom_colors.red, //substitute of accent color
  );
}

ElevatedButtonThemeData _elevatedButtonThemeData() {
  return ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(4.0),
      overlayColor: MaterialStateProperty.all(Colors.black12),
      backgroundColor: MaterialStateProperty.all(custom_colors.red),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 32.0,
        ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  );
}

TextSelectionThemeData _textSelectionTheme() {
  return const TextSelectionThemeData(
    selectionHandleColor: custom_colors.red,
    cursorColor: custom_colors.red,
  );
}

InputDecorationTheme _inputDecorationTheme() {
  return InputDecorationTheme(
    contentPadding: const EdgeInsets.all(16.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: custom_colors.lightGray,
    errorStyle: const TextStyle(color: custom_colors.red),
    errorMaxLines: 2,
  );
}

AppBarTheme _appBarTheme() {
  return const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    backgroundColor: custom_colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: custom_colors.black,
    ),
    actionsIconTheme: IconThemeData(
      color: custom_colors.black,
    ),
  );
}

CardTheme _cardTheme() {
  return CardTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 4.0,
  );
}

DialogTheme _dialogTheme() {
  return const DialogTheme(
    elevation: 0,
    titleTextStyle: TextStyle(
      fontSize: 18.0,
      fontFamily: 'OpenSans',
      color: custom_colors.black,
      fontWeight: FontWeight.w500,
    ),
  );
}
