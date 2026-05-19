import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  final _storage = const FlutterSecureStorage();

  Future<void> saveTokens(String accessToken, String refreshToken) async{
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);

    Future<String?> getAccessToken() async{
      return await _storage.read(key: 'accessToken');
    }

    Future<void> clear() async{
      await _storage.deleteAll();
    }
  }
}