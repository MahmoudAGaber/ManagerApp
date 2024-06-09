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
    print('Fetching todos...');
    final List<TodoModel> localTodos = await localTodoDataSource.getLocalTodos();

    if (localTodos.isEmpty) {
      print('Local todos empty. Fetching from API...');
      try {
        final List<TodoModel> todosFromApi = await todoDataSource.fetchTodos();
        await localTodoDataSource.saveLocalTodos(todosFromApi);
        print('Todos fetched successfully from API.');
        return todosFromApi;
      } catch (e) {
        print('Failed to fetch todos from API: $e');
        throw e;
      }
    } else {
      print('Local todos found.');
      return localTodos;
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    print('Adding todo: $todo');
    try {
      await localTodoDataSource.addLocalTodo(todo);
      print('Todo added successfully.');
    } catch (e) {
      print('Failed to add todo: $e');
      throw e;
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    print('Updating todo: $todo');
    try {
      await localTodoDataSource.updateLocalTodo(todo);
      print('Todo updated successfully.');
    } catch (e) {
      print('Failed to update todo: $e');
      throw e;
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    print('Deleting todo with ID: $id');
    try {
      await localTodoDataSource.deleteLocalTodo(id);
      print('Todo deleted successfully.');
    } catch (e) {
      print('Failed to delete todo: $e');
      throw e;
    }
  }
}
