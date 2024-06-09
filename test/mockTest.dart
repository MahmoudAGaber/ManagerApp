import 'package:flutter_test/flutter_test.dart';
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';
import 'package:managerapp/presentation/providers/todo_provider.dart';
import 'package:mockito/mockito.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  group('TodoProvider Tests', () {
    late TodoProvider todoProvider;
    late MockTodoRepository mockTodoRepository;

    setUp(() {
      mockTodoRepository = MockTodoRepository();
      todoProvider = TodoProvider(todoRepository: mockTodoRepository);
    });

    test('Fetch Todos Test', () async {
      final todos = [
        TodoModel(id: 1, todo: 'Task 1', completed: false),
        TodoModel(id: 2, todo: 'Task 2', completed: true),
      ];
      when(mockTodoRepository.getTodos()).thenAnswer((_) async => todos);
      await todoProvider.fetchTodos();
      expect(todoProvider.todos, todos);
    });

    test('Add Todo Test', () async {
      final todo = TodoModel(id: 1, todo: 'Test Task', completed: false);
      when(mockTodoRepository.addTodo(todo)).thenAnswer((_) async {});
      await todoProvider.addTodo(todo);
      expect(todoProvider.todos.contains(todo), true);
    });

    test('Update Todo Test', () async {
      final todo = TodoModel(id: 1, todo: 'Test Task', completed: false);
      when(mockTodoRepository.updateTodo(todo)).thenAnswer((_) async {});
      await todoProvider.updateTodo(todo);
      expect(todoProvider.todos.contains(todo), true);
    });

    test('Delete Todo Test', () async {
      final todoId = 1;
      when(mockTodoRepository.deleteTodo(todoId)).thenAnswer((_) async {});
      await todoProvider.deleteTodo(todoId);
      expect(todoProvider.todos.isEmpty, true);
    });
  });
}
