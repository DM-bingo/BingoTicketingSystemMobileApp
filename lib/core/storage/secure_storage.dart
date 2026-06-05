import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> logout() async {
    await _storage.deleteAll(); 
  }

  Future<void> saveTokens(String accessToken, String refreshToken) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
  }

  Future<void> saveUsername(String username) async {
    await _storage.write(key: 'username', value: username);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  Future<String?> getUsername() async {
  return await _storage.read(key: 'username');
}

  Future<void> saveUserId(int id) async{
  await _storage.write(key: 'userId', value: id.toString());
}

  Future<int?> getUserId() async{
    final id = await _storage.read(key: 'userId');
    return id != null ? int.parse(id) : null;
  }


}
