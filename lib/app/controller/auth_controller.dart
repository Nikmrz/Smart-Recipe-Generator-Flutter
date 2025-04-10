import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class AuthController extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<void> checkLoginStatus() async {
    String? token = await AuthService().getAuthToken();
    _isLoggedIn = token != null;
    notifyListeners();
  }

  void login(String token) async {
    await AuthService().saveLoginState(token);
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() async {
    await AuthService().logout();
    _isLoggedIn = false;
    notifyListeners();
  }
}
