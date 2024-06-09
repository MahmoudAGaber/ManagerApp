
import 'package:flutter/material.dart';
import 'package:managerapp/data/model/todo_model.dart';
import 'package:managerapp/data/model/user_model.dart';
import 'package:managerapp/data/sources/local_storage.dart';
import 'package:managerapp/presentation/providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final ScrollController _scrollController = ScrollController();
  int skip = 0;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoProvider>().fetchTodos();
    });

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      context.read<TodoProvider>().fetchTodos();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Manager'),
        automaticallyImplyLeading: false,

      ),
      body: todoProvider.loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        controller: _scrollController,
        itemCount: todoProvider.todos.length,
        itemBuilder: (context, index) {
          final todo = todoProvider.todos[index];
          return ListTile(
            title: Text(todo.todo!),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                todoProvider.deleteTodo(todo.id!);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TodoDetailScreen(todo: todo,index: index,),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TodoDetailScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }

}




class TodoDetailScreen extends StatefulWidget {
  final TodoModel? todo;
  final int? index;

  TodoDetailScreen({this.todo,this.index});

  @override
  _TodoDetailScreenState createState() => _TodoDetailScreenState();
}

class _TodoDetailScreenState extends State<TodoDetailScreen> {
  final TextEditingController _titleController = TextEditingController();
  LocalTodoDataSource localTodoDataSource = LocalTodoDataSource();
  bool _completed = false;
  UserModel? userModel;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)async {
      userModel = await localTodoDataSource.getUser();
    });
    if (widget.todo != null) {
      _titleController.text = widget.todo!.todo!;
      _completed = widget.todo!.completed!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo == null ? 'Add Todo' : 'Edit Todo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Todo Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a todo title';
                  }
                  return null;
                },
              ),
              CheckboxListTile(
                title: Text('Completed'),
                value: _completed,
                onChanged: (value) {
                  setState(() {
                    _completed = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) { // Check if form is valid
                      if (widget.todo == null) {
                        final todo = TodoModel(
                          id: DateTime.now().millisecondsSinceEpoch,
                          todo: _titleController.text,
                          completed: _completed,
                          userId: userModel!.id,
                        );
                        print("Add");
                        todoProvider.addTodo(todo);
                      } else {
                        final todo = TodoModel(
                          id: widget.todo!.id,
                          todo: _titleController.text,
                          completed: _completed,
                          userId: userModel!.id,
                        );
                        print("Edit${todo.id}");
                        todoProvider.updateTodo(todo);
                      }
                      Navigator.pop(context);
                    }
                  },
                child: Text(widget.todo == null ? 'Add Task' : 'Update Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
