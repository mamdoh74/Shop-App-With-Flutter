import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme ()=> ThemeData(
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.white,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.black,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
  ),
  textTheme: TextTheme(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.grey,
  ),
  fontFamily: 'mamdoh_fonts',
);

ThemeData darkTheme ()=> ThemeData(
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: HexColor('333739'),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.deepPurple,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.black,
    elevation: 0,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarColor: Colors.white,
    ),
    iconTheme: IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 30,
      fontWeight: FontWeight.w700,
    ),
  ),
  textTheme: TextTheme(),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('333739'),
    type: BottomNavigationBarType.fixed,
    elevation: 20,
    selectedItemColor: Colors.deepPurple,
    unselectedItemColor: Colors.grey,
  ),
  fontFamily: 'mamdoh_fonts',
);