import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/views/add_todo_view.dart';
import 'package:todo_list_app/views/login_register_view.dart';
import 'package:todo_list_app/views/todo_home_view.dart';
import 'package:todo_list_app/functions/todo_provider.dart';
import 'package:todo_list_app/views/todo_views.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); 
  await Firebase.initializeApp(); 
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget{
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context){
    return 
      ChangeNotifierProvider(create: (_) => AppUsers(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true, brightness: Brightness.dark
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: FirebaseGetUserDetails().firebaseCurrentUser(),
          builder:(context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done){
              if(snapshot.hasData && snapshot.data.emailVerified){return const TodoHome();}
              else {return const LoginPage();}
            } else{return const CircularProgressIndicator();}
          },
        ),
        routes: {
          loginPageRoute: (context) => const LoginPage(),
          homePageRoute: (context) => const TodoHome(),
          addTodoPageRoute: (context) => const AddUpdate(),
          viewPageRoute: (context) => const Views()
        }
      ),
    );
  }
}