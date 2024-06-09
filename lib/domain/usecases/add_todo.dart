
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<void> call(TodoModel todo) async {
    await repository.addTodo(todo);
  }
}
