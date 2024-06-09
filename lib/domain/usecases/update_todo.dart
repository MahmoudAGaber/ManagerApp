
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';

class UpdateTodo {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  Future<void> call(TodoModel todo) async {
    await repository.updateTodo(todo);
  }
}
