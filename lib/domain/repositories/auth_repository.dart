abstract class AuthRepository {
  Future<Map<String, dynamic>?> login(String otp);
}