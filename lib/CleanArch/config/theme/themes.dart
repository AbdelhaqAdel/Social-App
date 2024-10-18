import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

const defultColor = Colors.blue;

ThemeData lightTheme = ThemeData(
  primarySwatch: defultColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: defultColor,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.deepOrange,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: Colors.white,
  ),
  textTheme:  const TextTheme(
    bodyLarge:TextStyle(
      fontSize:15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium:TextStyle(
      fontSize:25,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),

);

ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: defultColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.deepOrange,
  ),
  appBarTheme: AppBarTheme(
    titleSpacing: 20,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarColor:Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: HexColor('333739'),
    elevation: 0.0,
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: Colors.deepOrange,
    unselectedItemColor: Colors.grey,
    elevation: 30,
    backgroundColor: HexColor('333739'),
  ),
  textTheme: const TextTheme(
    bodyMedium:TextStyle(
      fontSize:25,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    titleMedium:TextStyle(
      fontSize:16,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),

  ),
);

