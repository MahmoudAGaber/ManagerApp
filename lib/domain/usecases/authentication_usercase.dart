

import 'package:managerapp/data/model/user_model.dart';
import 'package:managerapp/domain/repositories/auth_repository.dart';

class AuthenticateUser {
  final AuthRepository repository;

  AuthenticateUser(this.repository);

  Future<UserModel> call(String username, String password) async {
    return await repository.authenticateUser(username, password);
  }
}
