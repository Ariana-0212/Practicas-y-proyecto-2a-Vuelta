import 'package:flutter/material.dart';

class SettingsLogic extends ValueNotifier<ThemeMode> {
  // Singleton pattern for global access if needed,
  // though ValueListenableBuilder in main is cleaner.
  static final SettingsLogic _instance = SettingsLogic._internal();

  factory SettingsLogic() {
    return _instance;
  }

  SettingsLogic._internal() : super(ThemeMode.dark);

  void toggleTheme(bool isLight) {
    value = isLight ? ThemeMode.light : ThemeMode.dark;
  }

  bool get isDarkMode => value == ThemeMode.dark;
}
