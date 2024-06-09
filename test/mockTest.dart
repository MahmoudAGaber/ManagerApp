import 'package:flutter_test/flutter_test.dart';
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';
import 'package:mockito/mockito.dart';

import '../lib/presentation/providers/todo_provider.dart';


// Mock classes
class MockTaskRepository extends Mock implements TodoRepository {}

void main() {

  group('TaskProvider Tests', () {
    late TodoProvider todoProvider;
    late MockTaskRepository mockTaskRepository;

    setUp(() {
      mockTaskRepository = MockTaskRepository();
      todoProvider = TodoProvider(todoRepository: mockTaskRepository);
    });

    test('Add Task Test', () async {
      // Arrange
      final task = TodoModel(id: 1, todo: 'Test Task', completed: false);

      // Mock repository response
      when(mockTaskRepository.addTodo(task)).thenAnswer((_) async => Future.value());

      // Act
      await todoProvider.addTodo(task);

      // Assert
      expect(todoProvider.todos.contains(task), true);
    });

    test('Update Task Test', () async {
      // Arrange
      final updatedTodo = TodoModel(id: 1, todo: 'Updated Task', completed: true);

      // Mock repository response
      when(mockTaskRepository.updateTodo(updatedTodo)).thenAnswer((_) async => Future.value());

      // Act
      await todoProvider.updateTodo(updatedTodo);

      // Assert
      final todo = todoProvider.todos.firstWhere((t) => t.id == updatedTodo.id);
      expect(todo.todo, 'Updated Task');
      expect(todo.completed, true);
    });

    // Similar tests can be written for deleteTask and fetchTasks

    test('Input Validation Test', () {
      // Arrange
      final invalidTodo = TodoModel(id: 1, todo: '', completed: false);

      // Act & Assert
      expect(() => todoProvider.addTodo(invalidTodo), throwsException);
    });

    test('Network Request Test', () async {
      // Arrange
      final tasks = [
        TodoModel(id: 1, todo: 'Task 1', completed: false),
        TodoModel(id: 2, todo: 'Task 2', completed: true),
      ];

      // Mock repository response
      when(mockTaskRepository.getTodos()).thenAnswer((_) async => tasks);

      // Act
      await todoProvider.fetchTodos();

      // Assert
      expect(todoProvider.todos, tasks);
    });

    // Additional tests can be added for error handling, state management, etc.
  });
}
