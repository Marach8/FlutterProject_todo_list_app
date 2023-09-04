import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/add_todo.dart';
import 'package:todo_list_app/login_register.dart';
import 'package:todo_list_app/todo_home.dart';
import 'package:todo_list_app/todo_provider.dart';
import 'package:todo_list_app/view_todo.dart';

void main() => runApp(const TodoApp());

class TodoApp extends StatelessWidget{
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => User())],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true, brightness: Brightness.dark
        ),
        debugShowCheckedModeBanner: false,
        home: const LoginPage(),
        initialRoute: '/',
        routes: {
          '/home': (context) => const TodoHome(),
          '/add': (context) => const AddUpdate(),
          '/view': (context) => const Views()
        }
      ),
    );
  }
}