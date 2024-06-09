
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:managerapp/data/model/user_model.dart';
import 'package:managerapp/data/sources/local_storage.dart';


class AuthDataSource {
  final String baseUrl = 'https://dummyjson.com';
  LocalTodoDataSource localTodoDataSource = LocalTodoDataSource();

  Future<UserModel> authenticate(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: jsonEncode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print(response.body);
      UserModel userModel = UserModel.fromJson(jsonDecode(response.body));
      await localTodoDataSource.saveUser(userModel);
      return userModel;
    } else {
      throw Exception('Failed to authenticate user');
    }
  }
}
