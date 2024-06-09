import 'package:managerapp/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:managerapp/data/model/todo_model.dart';

class LocalTodoDataSource {
  static const String todoListKey = 'todo_list';
  static const String userKey = 'user';

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<TodoModel>> getLocalTodos() async {
    final SharedPreferences prefs = await _prefs;
    final String? todosJson = prefs.getString(todoListKey);

    if (todosJson != null) {
      final List<dynamic> todoListMap = json.decode(todosJson);
      return todoListMap.map((todoJson) => TodoModel.fromJson(todoJson)).toList();
    } else {
      return [];
    }
  }

  Future<void> addLocalTodo(TodoModel todo) async {
    final List<TodoModel> todos = await getLocalTodos();
    todos.add(todo);
    await saveLocalTodos(todos);
  }

  Future<void> updateLocalTodo(TodoModel todo) async {
    final List<TodoModel> todos = await getLocalTodos();
    final int index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = todo;
      await saveLocalTodos(todos);
    }
  }

  Future<void> deleteLocalTodo(int id) async {
    final List<TodoModel> todos = await getLocalTodos();
    todos.removeWhere((todo) => todo.id == id);
    await saveLocalTodos(todos);
  }

  Future<void> saveLocalTodos(List<TodoModel> todos) async {
    final SharedPreferences prefs = await _prefs;
    final String todosJson = json.encode(todos.map((todo) => todo.toJson()).toList());
    prefs.setString(todoListKey, todosJson);
  }

  Future<void> saveUser(UserModel user) async {
    final SharedPreferences prefs = await _prefs;
    final String userJson = json.encode(user.toJson());
    prefs.setString(userKey, userJson);
  }

  Future<UserModel?> getUser() async {
    final SharedPreferences prefs = await _prefs;
    final String? userJson = prefs.getString(userKey);

    if (userJson != null) {
      final Map<String, dynamic> userMap = json.decode(userJson);
      return UserModel.fromJson(userMap);
    } else {
      return null;
    }
  }

}
