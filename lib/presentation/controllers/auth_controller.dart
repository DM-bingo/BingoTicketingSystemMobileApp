import 'package:bingo_ticketing_system_mobile/data/services/auth_storage.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthController {
  final AuthRepository repository;
  final AuthStorage storage;

  AuthController(this.repository, this.storage);

  Future<void> logout() async {
    await storage.logout();
  }

  Future<bool> login(String otp) async {
    try {
      final result = await repository.login(otp);
      print("RESULT: $result");

      if (result != null) {
        await storage.saveTokens(
          result['accessToken'],
          result['refreshToken'],
        );

        print("TOKENS SAVED");

        await storage.saveUsername(result['username']);
        await storage.saveUserId(result['userId']);

        if (result['userLocation'] != null) {
          await storage.saveLocationId(result['userLocation']['id']);
        }

        if (result['userLocationGroup'] != null) {
          await storage.saveLocationGroupId(
            result['userLocationGroup']['id'],
          );
        }

        return true;
      }

      return false;
    } catch (e) {
      print("LOGIN ERROR: $e");
      rethrow;
    }
  }
}