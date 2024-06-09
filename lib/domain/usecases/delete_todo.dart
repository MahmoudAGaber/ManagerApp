


import 'package:managerapp/domain/repositories/todo_repository.dart';

class DeleteTodo {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  Future<void> call(int todoId) async {
    await repository.deleteTodo(todoId);
  }
}
