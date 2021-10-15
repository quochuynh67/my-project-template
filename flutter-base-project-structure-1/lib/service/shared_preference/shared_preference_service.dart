import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  SharedPreferenceService(
    this._pref,
  );

  static const String ACCESS_TOKEN = 'access_token';

  final SharedPreferences _pref;

  /// clear _pref when logout.
  Future<bool> clear() {
    return _pref.clear();
  }

  /// language
  Future<bool> setCurrentLanguage(String lang) =>
      _pref.setString('current_language', lang);

  String? getCurrentLanguage() => _pref.getString('current_language');
}
