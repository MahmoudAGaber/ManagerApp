


import 'package:flutter/material.dart';
import 'package:managerapp/data/repositories/auth_repository_impl.dart';
import 'package:managerapp/data/repositories/todo_repository_impl.dart';
import 'package:managerapp/data/services/client.dart';
import 'package:managerapp/data/services/token_manager.dart';
import 'package:managerapp/data/sources/auth_data_source.dart';
import 'package:managerapp/data/sources/local_storage.dart';
import 'package:managerapp/data/sources/todo_data_source.dart';
import 'package:managerapp/domain/repositories/auth_repository.dart';
import 'package:managerapp/domain/repositories/todo_repository.dart';
import 'package:managerapp/presentation/providers/auth_provider.dart';
import 'package:managerapp/presentation/providers/todo_provider.dart';
import 'package:managerapp/presentation/screens/splach_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final todoDataSource = TodoDataSource(ClientWithTokenInterceptor(tokenManager: TokenManager()));
  final todoRepository = TodoRepositoryImpl(LocalTodoDataSource(),todoDataSource);

  final authDataSource = AuthDataSource();
  final authRepositoryImpl = AuthRepositoryImpl(authDataSource);

  runApp(MyApp(todoRepository: todoRepository, authRepository: authRepositoryImpl,));
}

class MyApp extends StatelessWidget {
  final TodoRepository? todoRepository;
  final AuthRepository? authRepository;


  const MyApp({Key? key, this.todoRepository, this.authRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider(authRepository: authRepository!)),
        ChangeNotifierProvider(create: (_) => TodoProvider(todoRepository: todoRepository!)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplachScreen(),
      ),
    );
  }
}
