// import 'dart:async';
// import 'package:flutter/foundation.dart';
// import 'package:flutterbaseproject/service/shared_preference/shared_preference_service.dart';
// import 'package:rxdart/rxdart.dart';
// import 'country_code.dart';
// import 'language_resource/en.dart';
// import 'language_resource/ko.dart';
// import 'language_resource/vi.dart';
@Deprecated('Use Flutter Intl to handle multiple language instead this way')
class LanguageService {
  // LanguageService(this._prefService) {
  //   currentLang = _prefService.getCurrentLanguage() ?? CountryCode.EN;
  //
  //   _bsLangIn = BehaviorSubject();
  //   bsLangOut = BehaviorSubject();
  //
  //   _subscriptionLang = _bsLangIn.listen((lang) {
  //     if (lang != currentLang) {
  //       currentLang = lang;
  //       _prefService.setCurrentLanguage(lang);
  //       bsLangOut.add(currentLang);
  //     }
  //   });
  // }
  //
  // String currentLang = CountryCode.EN;
  //
  // late BehaviorSubject<String> _bsLangIn;
  // late BehaviorSubject<String> bsLangOut;
  //
  // final _language = {
  //   CountryCode.EN: enLanguage,
  //   CountryCode.KO: koLanguage,
  //   CountryCode.VI: viLanguage,
  // };
  //
  // late StreamSubscription<String> _subscriptionLang;
  //
  // final SharedPreferenceService _prefService;
  //
  // BehaviorSubject<String> getBsLangIn() => _bsLangIn;
  //
  // void dispose() {
  //   debugPrint('LanguageService: dispose');
  //   _subscriptionLang.cancel();
  //   _bsLangIn.close();
  //   bsLangOut.close();
  // }
  //
  // String? _getLang(String key, {required List value}) {
  //   if (_language[currentLang] == null)
  //     throw Exception('Not found key: $key in $currentLang');
  //   if (value != null) {
  //     return _language[currentLang][key](value) ??
  //         (throw Exception('Not found key: $key in $currentLang'));
  //   } else {
  //     return _language[currentLang]![key] ??
  //         (throw Exception('Not found key: $key in $currentLang'));
  //   }
  // }
  //
  // String getStringKey(String key, {required List value}) {
  //   try {
  //     return _getLang(key, value: value);
  //   } catch (e) {
  //     debugPrint('MultipleLanguageError: $e');
  //     return key;
  //   }
  // }
  //
  // /// Change language
  // void changeLanguage(String lang) => _bsLangIn.add(lang);
  //
  // String getCurrentLanguage() {
  //   switch (currentLang) {
  //     case CountryCode.EN:
  //       return 'English';
  //     case CountryCode.KO:
  //       return '한국어';
  //     case CountryCode.VI:
  //       return 'Tiếng Việt';
  //     default:
  //       return 'English';
  //   }
  // }
  //
  // /// get current locale
  // String getLocale() {
  //   switch (currentLang) {
  //     case CountryCode.EN:
  //       return 'en-EN';
  //     case CountryCode.KO:
  //       return 'ko-KR';
  //     case CountryCode.VI:
  //       return 'vi-VI';
  //     default:
  //       return 'en-EN';
  //   }
  // }
}
