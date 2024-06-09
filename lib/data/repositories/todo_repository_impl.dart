
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/data/sources/local_storage.dart';
import 'package:managerapp/data/sources/todo_data_source.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final LocalTodoDataSource localTodoDataSource;
  final TodoDataSource todoDataSource;

  TodoRepositoryImpl(this.localTodoDataSource, this.todoDataSource);

  @override
  Future<List<TodoModel>> getTodos({int limit = 10, int skip = 0}) async {
    final List<TodoModel> localTodos = await localTodoDataSource.getLocalTodos();

    if (localTodos.isEmpty) {
      final List<TodoModel> todosFromApi = await todoDataSource.fetchTodos();

      await localTodoDataSource.saveLocalTodos(todosFromApi);

      return todosFromApi;
    } else {
      return localTodos;
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await localTodoDataSource.addLocalTodo(todo);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await localTodoDataSource.updateLocalTodo(todo);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await localTodoDataSource.deleteLocalTodo(id);
  }
}
