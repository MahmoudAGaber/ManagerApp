


import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';

class GetTodos {
  final TodoRepository repository;

  GetTodos(this.repository);

  Future<List<TodoModel>> call({int limit = 10, int skip = 0}) async {
    return await repository.getTodos(limit: limit, skip: skip);
  }
}
