import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Colors.red,
    closeIconColor: Colors.white,
  ),
  iconTheme: IconThemeData(color: Colors.grey[800]),
 primarySwatch: Colors.grey,
 
  colorScheme: ColorScheme.light(
    surface: Colors.blue,
    primary: Colors.white,
    secondary: Colors.black,
  ),
);

ThemeData darkMode = ThemeData();
