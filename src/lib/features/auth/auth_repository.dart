import 'package:my_app/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<void> login(String email, String password) async {
    try {
      await _authService.login(email, password);
    } catch (e) {
      throw Exception(
          'Unable to log in. Please check your credentials and try again.');
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      await _authService.register(email, password, name);
    } catch (e) {
      throw Exception('Unable to create account. Please try again later.');
    }
  }

  Future<void> logout() async {
    try {
      await _authService.logout();
    } catch (e) {
      throw Exception('Unable to log out. Please try again.');
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      return await _authService.isAuthenticated();
    } catch (e) {
      return false;
    }
  }
}
