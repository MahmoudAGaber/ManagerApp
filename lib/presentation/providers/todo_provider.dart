import 'package:flutter/material.dart';
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';

class TodoProvider extends ChangeNotifier with ApiState {

  final TodoRepository todoRepository;
  List<TodoModel> todos = [];

  TodoProvider({required this.todoRepository});

  Future<void> fetchTodos() async {
  todos = await todoRepository.getTodos();
  notifyListeners();
  }

  Future<void> addTodo(TodoModel todo) async {
  await todoRepository.addTodo(todo);
  fetchTodos();
  }

  Future<void> updateTodo(TodoModel todo) async {
  await todoRepository.updateTodo(todo);
  fetchTodos();
  }

  Future<void> deleteTodo(int id) async {
  await todoRepository.deleteTodo(id);
  fetchTodos();
  }
}

mixin ApiState on ChangeNotifier {
  bool loading = false;
  String error = "";

  void setLoading(bool isLoading) {
    loading = isLoading;
  }
}
