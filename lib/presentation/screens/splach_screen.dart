

import 'package:flutter/material.dart';
import 'package:managerapp/data/model/user_model.dart';
import 'package:managerapp/data/sources/local_storage.dart';
import 'package:managerapp/presentation/screens/auth/Login.dart';
import 'package:managerapp/presentation/screens/home/home.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {

  LocalTodoDataSource localTodoDataSource = LocalTodoDataSource();
  UserModel? user;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      user = await localTodoDataSource.getUser();

      Future.delayed(Duration(seconds: 1),(){
        if(user !=null){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskListScreen()));
        }else{
          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

        }
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text("TASK MANAGER",style: TextStyle(fontSize: 22),))
        ],
      ),
    );
  }
}
