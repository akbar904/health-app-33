import 'package:stacked/stacked.dart';
import 'package:my_app/features/auth/auth_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class AuthViewModel extends BaseViewModel {
  final AuthRepository _authRepository;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  AuthViewModel(
    this._authRepository,
    this._navigationService,
    this._dialogService,
  );

  String? _email;
  String? _password;
  String? _name;
  String? _modelError;

  String? get email => _email;
  String? get password => _password;
  String? get name => _name;
  String? get modelError => _modelError;

  void setEmail(String value) {
    _email = value;
    _modelError = null;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    _modelError = null;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    _modelError = null;
    notifyListeners();
  }

  Future<void> login() async {
    try {
      setBusy(true);
      _modelError = null;

      if (_email == null || _email!.isEmpty) {
        _modelError = 'Please enter your email';
        return;
      }
      if (_password == null || _password!.isEmpty) {
        _modelError = 'Please enter your password';
        return;
      }

      await _authRepository.login(_email!, _password!);
      await _navigationService.clearStackAndShow('/home');
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> register() async {
    try {
      setBusy(true);
      _modelError = null;

      if (_name == null || _name!.isEmpty) {
        _modelError = 'Please enter your name';
        return;
      }
      if (_email == null || _email!.isEmpty) {
        _modelError = 'Please enter your email';
        return;
      }
      if (_password == null || _password!.isEmpty) {
        _modelError = 'Please enter your password';
        return;
      }

      await _authRepository.register(_email!, _password!, _name!);
      await _navigationService.clearStackAndShow('/home');
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }

  Future<void> logout() async {
    try {
      setBusy(true);
      await _authRepository.logout();
      await _navigationService.clearStackAndShow('/login');
    } catch (e) {
      _modelError = e.toString();
      await _dialogService.showDialog(
        title: 'Error',
        description: _modelError,
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      setBusy(true);
      final isAuthenticated = await _authRepository.isAuthenticated();
      if (isAuthenticated) {
        await _navigationService.clearStackAndShow('/home');
      } else {
        await _navigationService.clearStackAndShow('/login');
      }
    } catch (e) {
      _modelError = e.toString();
    } finally {
      setBusy(false);
    }
  }
}
