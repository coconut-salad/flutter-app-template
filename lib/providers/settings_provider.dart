import "dart:convert";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../models/models.dart";

class SettingsNotifier extends StateNotifier<Settings> {
  final SharedPreferences _sharedPreferences;
  static const _settingsKey = "app_settings";

  SettingsNotifier(this._sharedPreferences) : super(const Settings()) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final settingsJson = _sharedPreferences.getString(_settingsKey);
    if (settingsJson != null) {
      try {
        final Map<String, dynamic> decoded = json.decode(settingsJson);
        state = Settings.fromJson(decoded);
      } catch (e) {
        // If loading fails, keep default settings
      }
    }
  }

  Future<void> _saveSettings() async {
    await _sharedPreferences.setString(_settingsKey, json.encode(state.toJson()));
  }

  Future<void> updateSettings(Settings Function(Settings) update) async {
    state = update(state);
    await _saveSettings();
  }

  Future<void> setShowBadges(bool value) async {
    await updateSettings((settings) => settings.copyWith(showBadges: value));
  }
}
