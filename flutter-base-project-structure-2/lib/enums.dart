enum Language { ko, en }

extension LanguageExt on Language {
  String get code => ['ko', 'en'][index];
}