import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController {
  final AuthRepository repository;
  final AuthStorage storage;

  AuthController(this.repository, this.storage);

  Future<bool> login(String otp) async {
    final result = await repository.login(otp);

    if (result != null) {
      await storage.saveTokens(
        result['accessToken'],
        result['refreshToken'],
      );
      return true;
    }
    return false;
  }
}