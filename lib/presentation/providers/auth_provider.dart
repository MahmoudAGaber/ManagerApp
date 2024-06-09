

import 'package:flutter/material.dart';
import 'package:managerapp/data/model/user_model.dart';
import 'package:managerapp/domain/repositories/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepository authRepository;

  AuthProvider({required this.authRepository});

  UserModel? _user;
  bool _isLoading = false;
  String? _error;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _user = await authRepository.authenticateUser(username, password);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
