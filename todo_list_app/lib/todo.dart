import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/todo_provider.dart';

class TodoHome extends StatefulWidget{
  const TodoHome({super.key});

  @override 
  State<TodoHome> createState() => _Td();
}

class _Td extends State<TodoHome>{

  @override 
  Widget build(BuildContext context){

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    
    return Consumer<User>(
      builder: ((context, user, child)
        => Scaffold(
          appBar: AppBar( 
            centerTitle: true, title: const Text('My Todo'),
            backgroundColor: Colors.deepPurple,           
          ),
          body: Container(
            height: h, width: w,
            child: Column(
              children: [
                Container(
                  child: Text(
                    'Hello, Welcime To our Todo Manager',
                    style: TextStyle(
                      fontFamily: 'monospace', fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )
                  )
                )
              ]
            )
          )
        )
      )
    );
  }
}