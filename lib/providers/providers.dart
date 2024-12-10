import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:shared_preferences/shared_preferences.dart";

import "../api/api_client.dart";
import "../api/auth_service.dart";
import "../api/client.dart";
import "../api/offline_client.dart";
import "../models/models.dart";
import "settings_provider.dart";

export "language_provider.dart";
export "settings_provider.dart";

final isAuthenticatedProvider = FutureProvider<bool>((ref) async {
  final cookies = await AuthService().getCookies();
  final apiKey = await AuthService().getApiKey();
  return cookies != null || apiKey != null;
});

final offlineModeProvider = StateProvider<bool>((ref) {
  return false;
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
      "SharedPreferences not initialized. Should be initialized in main.dart through ProviderScope overrides.");
});

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return SettingsNotifier(prefs);
});

final clientProvider = StateProvider<Client>((ref) {
  if (ref.watch(offlineModeProvider.notifier).state) {
    return Client(client: OfflineClient());
  } else {
    return Client(client: ApiClient());
  }
});

final badgesProvider = FutureProvider<Result<List<Badge>>>((ref) async {
  return await ref.watch(clientProvider).getBadges();
});
