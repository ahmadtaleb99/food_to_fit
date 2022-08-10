import 'dart:ui';

enum LanguageType { ENGLISH, ARABIC  }

class AppLanguages{


  static const Locale englishLocale = Locale("en", "US");
  static  const Locale arabicLocale =  Locale("ar", "SA");



}
extension xLanguageType on LanguageType {

  static const String _english = 'en';
  static const String _arabic = 'ar';

  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return _english;
      case LanguageType.ARABIC:
        return _arabic;
    }
  }
}