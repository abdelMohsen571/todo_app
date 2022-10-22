import 'package:flutter/material.dart';

class MyTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFDFECDB),
    primaryColor: Colors.blue,
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.blue, fontSize: 20, fontWeight: FontWeight.bold),
      headline2: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      subtitle1: TextStyle(
        color: Colors.black,
        fontSize: 15,
      ),
    ),
  );
}
