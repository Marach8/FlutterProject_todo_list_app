import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class Views extends StatefulWidget{
  const Views ({super.key});

  @override
  State<Views> createState() => _Views();
}

class _Views extends State<Views> {

  container(String heading, String content){
    return Container(
      padding: const EdgeInsets.all(10),                            
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(blurRadius: 5, spreadRadius: 1, color: Color.fromARGB(255, 170, 169, 249))
        ]
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: heading, style: GoogleFonts.getFont('Nunito', color: const Color.fromARGB(255, 170, 169, 249).withOpacity(0.6))
            ),
            TextSpan(
              text: content, style: GoogleFonts.getFont('Nunito', color:Colors.white)
            ),
          ]
        )
      )
    );
  }
  
  @override
  Widget build(BuildContext context){
    return Consumer<AppUsers>(
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
              final title = user.dataBase.elementAt(index)[0];
              final date = user.dataBase.elementAt(index)[1]; 
              final content = user.dataBase.elementAt(index)[2];                            
              return Dismissible(                
                key: Key(title),
                onDismissed: (direction){
                  if(direction == DismissDirection.endToStart){
                    user.delete(title, date, content, index);                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating, margin: const EdgeInsets.only(bottom:100),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        content: Text(
                          'Item deleted!', 
                          style: GoogleFonts.getFont('Nunito', fontSize:20, color: Colors.black, fontWeight: FontWeight.w300)
                        ),
                        action: SnackBarAction(
                          onPressed: () {user.undo(title, date, content, index);}, label: 'Undo', textColor: Colors.blue, 
                        ),
                        duration: const Duration(seconds: 4), backgroundColor: Colors.white,
                      )
                    );                    
                  } else if(direction == DismissDirection.startToEnd){
                      user.delete(title, date, content, index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating, margin: const EdgeInsets.only(bottom:100),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          content: Text(
                            'Item deleted!',
                             style: GoogleFonts.getFont('Nunito', fontSize:20, color: Colors.black, fontWeight: FontWeight.w300)
                          ),
                          action: SnackBarAction(
                            onPressed: () {user.undo(title, date, content, index);}, label: 'Undo', textColor: Colors.blue, 
                          ),
                          duration: const Duration(seconds: 2), backgroundColor: Colors.white,
                        )
                      ); 
                    }
                },
                background: Container(
                  padding: const EdgeInsets.only(left:10, right: 15),
                  height: 30, color: Colors.lightBlue.shade300, alignment: Alignment.centerLeft,
                  child: const Wrap(
                    children: [
                      Align(alignment: Alignment.bottomLeft, child: Icon(Icons.delete_rounded, color: Colors.red)),
                      Align(alignment: Alignment.centerRight, child: Icon(Icons.delete_rounded, color: Colors.red)),
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
                            container('TITLE OF TODO: ', title), const SizedBox(height: 10),
                            container('DATE/TIME OF TODO: ', date), const SizedBox(height: 10),
                            container('CONTENT OF TODO: ', content), const SizedBox(height: 10),
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
                    user.updateMode = true;
                    user.updateTodo(title, date, content, index);
                    Navigator.of(context).pop(); Navigator.of(context).pushNamed(addTodoPageRoute);
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