import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<Map<String, dynamic>?> login(String otp) async {
    try {
      final result = await service.activateUser(otp);
      return result;
    } catch (e) {
      print("ERROR: $e");
      return null;
    }
  }
}