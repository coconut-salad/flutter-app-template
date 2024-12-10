export "result.dart";
export "badge.dart";
export "settings.dart";

// ignore: constant_identifier_names
enum Language { English, German, Italian, French }

extension LanguageExtension on Language {
  String toNormalString() {
    switch (this) {
      case Language.English:
        return "English";
      case Language.German:
        return "German";
      case Language.Italian:
        return "Italian";
      case Language.French:
        return "French";
      default:
        return "English";
    }
  }
}

Language languageFromString(String language) {
  switch (language) {
    case "English":
      return Language.English;
    case "German":
      return Language.German;
    case "Italian":
      return Language.Italian;
    case "French":
      return Language.French;
    default:
      return Language.English;
  }
}
