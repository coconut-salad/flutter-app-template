import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:yaml/yaml.dart";

import "../models/models.dart";

class LanguageProvider extends ChangeNotifier {
  Language _selectedLanguage = Language.English; // Default language is English
  Language get selectedLanguage => _selectedLanguage;

  Locale _locale = const Locale("en");
  Locale get locale => _locale;

  List<String> shortenedWeekdays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
    "Total"
  ];

  dynamic _appLanguageDocument;

  LanguageProvider() {
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final preferences = await SharedPreferences.getInstance();
    final savedLanguage = preferences.getString("language");
    if (savedLanguage != null) {
      _selectedLanguage = languageFromString(savedLanguage);
      _setLocalization();
      loadLanguage();
      notifyListeners();
    }
  }

  void setLanguage(Language newLanguage) async {
    _selectedLanguage = newLanguage;
    _setLocalization();
    loadLanguage();

    // Save to shared preferences
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString("language", _selectedLanguage.toNormalString());

    notifyListeners();
  }

  void _setLocalization() {
    switch (_selectedLanguage) {
      case Language.English:
        _locale = const Locale("en");
        break;
      case Language.German:
        _locale = const Locale("de");
        break;
      case Language.Italian:
        _locale = const Locale("it");
        break;
      case Language.French:
        _locale = const Locale("fr");
        break;
      default:
        _locale = const Locale("en");
        break;
    }
  }

  String translate(String text) {
    if (_selectedLanguage == Language.English) {
      return text;
    } else {
      return _appLanguageDocument[text] ?? text;
    }
  }

  Future loadLanguage() async {
    switch (_selectedLanguage) {
      case Language.German:
        _appLanguageDocument =
            loadYaml(await rootBundle.loadString("assets/languages/de.yaml"));
        break;
      case Language.Italian:
        _appLanguageDocument =
            loadYaml(await rootBundle.loadString("assets/languages/it.yaml"));
        break;
      case Language.French:
        _appLanguageDocument =
            loadYaml(await rootBundle.loadString("assets/languages/fr.yaml"));
        break;
      default:
        _appLanguageDocument =
            loadYaml(await rootBundle.loadString("assets/languages/de.yaml"));
        break;
    }
  }
}

final languageProvider = ChangeNotifierProvider<LanguageProvider>((ref) {
  return LanguageProvider();
});
