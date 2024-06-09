
class TodoList {
  final List<TodoModel> todos;
  final int total;
  final int skip;
  final int limit;

  TodoList({
    required this.todos,
    required this.total,
    required this.skip,
    required this.limit,
  });

  factory TodoList.fromJson(Map<String, dynamic> json) {
    var todoJsonList = json['todos'] as List;
    List<TodoModel> todos =
    todoJsonList.map((todoJson) => TodoModel.fromJson(todoJson)).toList();

    return TodoList(
      todos: todos,
      total: json['total'],
      skip: json['skip'],
      limit: json['limit'],
    );
  }
}

class TodoModel{
  final dynamic id;
  final String? todo;
  final bool? completed;
  final int? userId;

  TodoModel({
     this.id,
     this.todo,
     this.completed,
     this.userId,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      todo: json['todo'],
      completed: json['completed'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'todo': todo,
      'completed': completed,
      'userId': userId,
    };
  }
}

