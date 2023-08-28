import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/todo_provider.dart';

class Views extends StatefulWidget{
  const Views ({super.key});

  @override
  State<Views> createState() => _Views();
}

class _Views extends State<Views> {
  
  @override
  Widget build(BuildContext context){
    return Consumer<User>(
      builder: (context, user, child) 
      => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true, title: const Text('Welcome to your views'),
            backgroundColor: Colors.white70,
          ),
          body: ListView.builder(
            itemCount: user.dataBase.length,
            itemBuilder: (context, index) {
              final title = user.dataBase.keys.elementAt(index);
              final date = user.dataBase[title]![0];
              final content = user.dataBase[title]![1];
              return Card(              
                child: ListTile(
                  leading: Text(
                    date,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis
                    )
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis
                      )
                    ),
                  subtitle: Text(
                    content,
                    style: const TextStyle(
                      overflow: TextOverflow.ellipsis
                    )
                  )
                )
              );
            }
          )
        )
    );
  }
}