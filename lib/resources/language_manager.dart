import 'dart:ui';

enum LanguageType { ENGLISH, ARABIC,PORTUGUESE  }

class AppLanguages{


  static const Locale englishLocale = Locale("en", "US");
  static  const Locale arabicLocale =  Locale("ar", "SA");
  static  const Locale portugueseLocale =  Locale("pt", "BR");



}
extension xLanguageType on LanguageType {

  static const String _english = 'en';
  static const String _arabic = 'ar';
  static const String _portuguese = 'pt';

  String getValue() {
    switch (this) {
      case LanguageType.ENGLISH:
        return _english;
      case LanguageType.ARABIC:
        return _arabic;
        case LanguageType.PORTUGUESE:
        return _portuguese;
    }
  }
}