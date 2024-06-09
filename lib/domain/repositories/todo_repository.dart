


import 'package:managerapp/data/model/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> getTodos({int limit, int skip});
  Future<void> addTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
}