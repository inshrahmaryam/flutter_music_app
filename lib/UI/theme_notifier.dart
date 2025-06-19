import 'package:flutter/material.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  ThemeData getTheme() => _currentTheme;

  void setLightMode() {
    _currentTheme = lightTheme;
    notifyListeners();
  }

  void setDarkMode() {
    _currentTheme = darkTheme;
    notifyListeners();
  }

  void setPinkMode() {
    _currentTheme = pinkTheme;
    notifyListeners();
  }

  void setGreenMode() {
    _currentTheme = greenTheme;
    notifyListeners();
  }

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.deepPurple,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.deepPurple),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.grey),
  );

  static final pinkTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.pink,
    scaffoldBackgroundColor: Colors.pink[50],
    appBarTheme: AppBarTheme(backgroundColor: Colors.pink[200]!),
  );

  static final greenTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.green[50],
    appBarTheme: AppBarTheme(backgroundColor: Colors.green[400]!),
  );
}
