
import 'package:managerapp/data/model/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> authenticateUser(String username, String password);
}

