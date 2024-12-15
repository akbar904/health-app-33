import 'package:stacked/stacked.dart';
import 'package:my_app/services/appwrite_service.dart';

class AuthService implements InitializableDependency {
  final AppwriteService _appwriteService;

  AuthService(this._appwriteService);

  @override
  Future<void> init() async {
    // Initialize any required auth state
  }

  Future<void> login(String email, String password) async {
    try {
      await _appwriteService.createSession(email, password);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  Future<void> register(String email, String password, String name) async {
    try {
      await _appwriteService.createAccount(email, password, name);
      await login(email, password);
    } catch (e) {
      throw Exception('Registration failed: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    try {
      await _appwriteService.logout();
    } catch (e) {
      throw Exception('Logout failed: ${e.toString()}');
    }
  }

  Future<bool> isAuthenticated() async {
    return _appwriteService.isAuthenticated();
  }
}
