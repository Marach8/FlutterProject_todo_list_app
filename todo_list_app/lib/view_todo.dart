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
  bool isTapped = false;
  
  @override
  Widget build(BuildContext context){
    return Consumer<User>(
      builder: (context, user, child) 
      => Scaffold(
          backgroundColor: Colors.blueGrey.withOpacity(0.25),
          appBar: AppBar(
            centerTitle: true, 
            title: Text(
              'Welcome to your views',
              style: GoogleFonts.getFont('Quicksand', fontWeight: FontWeight.bold, fontSize: 20,)
            ),
            backgroundColor: const Color.fromARGB(59, 106, 106, 106), foregroundColor: Colors.white,
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
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //     content: const Text('Item deleted!'),
                    //     action: SnackBarAction(onPressed: () {}, label: 'Undo',)
                    //   )
                    // );
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
                  contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        //animation: ,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                        ),
                        backgroundColor: Colors.blueGrey.shade900,                        
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),                            
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade900,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(blurRadius: 5, spreadRadius: 1, color: Color.fromARGB(255, 170, 169, 249))
                                ]
                              ),
                              child: Text('TITLE OF TODO: $title', style: GoogleFonts.getFont('Nunito', color:Colors.white))
                            ), const SizedBox(height: 10),
                            Container(
                              padding: const EdgeInsets.all(10),                            
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade900,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(blurRadius: 5, spreadRadius: 1, color: Color.fromARGB(255, 170, 169, 249))
                                ]
                              ),
                              child: Text('DATE/TIME OF TODO: $date', style: GoogleFonts.getFont('Nunito', color:Colors.white))
                            ), const SizedBox(height: 10),
                            Container(  
                              padding: const EdgeInsets.all(10),                            
                              decoration: BoxDecoration(
                                color: Colors.blueGrey.shade900,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: const [
                                  BoxShadow(blurRadius: 5, spreadRadius: 1, color: Color.fromARGB(255, 170, 169, 249))
                                ]
                              ),
                              child: Text('CONTENT OF TODO: $content', style: GoogleFonts.getFont('Nunito', color:Colors.white))
                            )
                          ]
                        ),
                        duration: const Duration(seconds: 10),
                        action: SnackBarAction(
                          onPressed: (){ScaffoldMessenger.of(context).hideCurrentSnackBar();},
                          label: 'Back', textColor: Colors.blue,
                        )
                      )
                    );
                  },
                  onLongPress: (){
                    user.updateTodo(title, date, content);
                    Navigator.of(context).pop(); Navigator.of(context).pushNamed('/add');
                  },
                  leading: const Icon(Icons.create, size: 40, color: Colors.blue,),
                  trailing: Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 10,
                      color: Colors.white70, overflow: TextOverflow.ellipsis
                    )
                  ),
                  title: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 18,
                      color: Colors.white, overflow: TextOverflow.ellipsis
                    )
                    ),
                  subtitle: Text(
                    content,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 14,
                      color: Colors.white70, overflow: TextOverflow.ellipsis
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