import "package:flutter_secure_storage/flutter_secure_storage.dart";

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  String? _token;
  String? _apiKey;

  Future<String?> getCookies() async {
    // If the token is null, fetch it from the storage
    _token ??= await _storage.read(key: "authToken");

    return _token;
  }

  Future<void> setCookies(String token) async {
    _token = token;
    await _storage.write(key: "authToken", value: token);
  }

  Future<void> deleteCookies() async {
    _token = null;
    await _storage.delete(key: "authToken");
  }

  Future<String?> getApiKey() async {
    // If the API key is null, fetch it from the storage
    _apiKey ??= await _storage.read(key: "apiKey");
    return _apiKey;
  }

  Future<void> setApiKey(String apiKey) async {
    _apiKey = apiKey;
    await _storage.write(key: "apiKey", value: apiKey);
  }

  Future<void> deleteApiKey() async {
    _apiKey = null;
    await _storage.delete(key: "apiKey");
  }
}
