

import 'package:managerapp/data/model/user_model.dart';
import 'package:managerapp/data/sources/auth_data_source.dart';
import 'package:managerapp/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<UserModel> authenticateUser(String username, String password) async {
    final userModel = await authDataSource.authenticate(username, password);
    return UserModel(
      id: userModel.id,
      userName: userModel.userName,
      email: userModel.email,
      firstName: userModel.firstName,
      lastName: userModel.lastName,
      gender: userModel.gender,
      image: userModel.image,
      token: userModel.token,
      refreshToken: userModel.refreshToken,
    );
  }
}