import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeNotifier(this._themeData);

  ThemeData _themeData;

  ThemeData getTheme() => _themeData;

  Future<void> setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  static bool getSystemTheme() {
    final Brightness? brightness =
        SchedulerBinding.instance?.window.platformBrightness;
    final bool darkModeOn = brightness == Brightness.dark;
    return darkModeOn;
  }
}
