import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveUsername(String username) async {
    await _storage.write(key: 'username', value: username);
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<String?> getUsername() async {
    return await _storage.read(key: 'username');
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<void> logout() async {
    await _storage.deleteAll();
  }
}