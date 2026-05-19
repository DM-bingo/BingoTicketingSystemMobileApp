import '../../domain/repositories/auth_repository.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService service;

  AuthRepositoryImpl(this.service);

  @override
  Future<Map<String, dynamic>?> login(String otp) {
    return service.activateUser(otp);
  }
}