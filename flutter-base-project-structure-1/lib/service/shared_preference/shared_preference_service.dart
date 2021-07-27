import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const String ACCESS_TOKEN = 'access_token';

  SharedPreferences _pref;

  SharedPreferenceService(
    this._pref,
  );

  /// clear _pref when logout.
  Future<bool> clear() {
    String? currentLanguage = getCurrentLanguage();
    return _pref.clear().then((done) {
      if (done) {
        return Future.wait([
          setCurrentLanguage(currentLanguage!),
        ]).then((list) {
          return true;
        }, onError: (e) {
          print('backup device info: onError: $e');
          return false;
        });
      } else {
        return false;
      }
    });
  }

  /// language
  Future<bool> setCurrentLanguage(String lang) =>
      _pref.setString('current_language', lang);

  String? getCurrentLanguage() => _pref.getString('current_language');
}
