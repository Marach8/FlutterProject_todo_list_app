import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/todo_provider.dart';

class Views extends StatefulWidget{
  const Views ({super.key});

  @override
  State<Views> createState() => _Views();
}

class _Views extends State<Views> {
  bool isDragged = false;
  
  @override
  Widget build(BuildContext context){
    return Consumer<User>(
      builder: (context, user, child) 
      => Scaffold(
          backgroundColor: const Color.fromARGB(31, 28, 28, 28),
          appBar: AppBar(
            centerTitle: true, 
            title: Text(
              'Welcome to your views',
              style: GoogleFonts.getFont('Quicksand', fontWeight: FontWeight.bold, fontSize: 20,)
            ),
            backgroundColor: const Color.fromARGB(60, 106, 106, 106), foregroundColor: Colors.white,
          ),
          body: ListView.builder(
            itemCount: user.dataBase.length,
            itemBuilder: (context, index) {
              final title = user.dataBase.keys.elementAt(index);             
              final date = user.dataBase[title]![0];
              final content = user.dataBase[title]![1];              
              return Dismissible(                
                key: Key(title),
                onDismissed: (direction){
                  if(direction == DismissDirection.endToStart){
                    setState(() => user.dataBase.remove(title));
                  } else if(direction == DismissDirection.startToEnd){
                    setState(() => user.dataBase.remove(title));
                  }              
                },
                background: Container(
                  padding: const EdgeInsets.only(left:10, right: 15),
                  height: 30, color: Colors.blue, alignment: Alignment.centerLeft,
                  child: const Wrap(
                    children: [
                      Align(alignment: Alignment.bottomLeft, child: Icon(Icons.delete_rounded)),
                      Align(alignment: Alignment.centerRight, child: Icon(Icons.delete_rounded)),
                    ]
                  )
                ),
                child: ListTile(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  onLongPress: (){
                    user.updateTodo(title, date, content);
                    Navigator.of(context).pop(); Navigator.of(context).pushNamed('/add');
                  },
                  leading: const Icon(Icons.create, size: 40, color: Colors.blue,),
                  trailing: Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15,
                      color: Colors.white60, overflow: TextOverflow.ellipsis
                    )
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 20,
                      color: Colors.white70, overflow: TextOverflow.ellipsis
                    )
                    ),
                  subtitle: Text(
                    content,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 15,
                      color: Colors.white60, overflow: TextOverflow.ellipsis
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