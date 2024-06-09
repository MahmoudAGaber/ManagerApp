import 'dart:convert';
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/data/services/client.dart';

class TodoDataSource {
  final ClientWithTokenInterceptor httpClient;

  TodoDataSource(this.httpClient);

  Future<List<TodoModel>> fetchTodos({int limit = 10, int skip = 0}) async {
    final response = await httpClient.get('/todos?limit=$limit&skip=$skip');
    if (response.statusCode == 200) {
      final List<TodoModel> todoList = TodoList.fromJson(jsonDecode(response.body)).todos;
      return todoList;
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> addTodo(TodoModel todo) async {
    final response = await httpClient.post('/todos/add', body: todo.toJson());
    if (response.statusCode != 200) {
      print(response.body);
      throw Exception('Failed to add todo');
    }
  }

  Future<void> updateTodo(TodoModel todo) async {
    final response = await httpClient.put('/todos/${todo.id}', body: todo.toJson());
    if (response.statusCode != 200) {
      print(response.body);

      throw Exception('Failed to update todo');
    }
  }

  Future<void> deleteTodo(int todoId) async {
    final response = await httpClient.delete('/todos/$todoId');
    if (response.statusCode != 200) {
      print(response.body);

      throw Exception('Failed to delete todo');
    }
  }
}
