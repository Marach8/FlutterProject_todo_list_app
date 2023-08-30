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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h*0.4,               
                  margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 97, 92, 92),
                        blurRadius: 10, spreadRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Hello, Welcome To Our Todo Manager',
                    style: TextStyle(
                      fontFamily: 'monospace', fontSize: 45,
                      fontWeight: FontWeight.bold,
                    )
                  )
                ),

                const SizedBox(height: 20),

                Wrap(
                  children: [
                    TextButton.icon(
                      onPressed: (){Navigator.of(context).pushNamed('/add');},
                      icon: const Icon(Icons.add),
                      label: const Text('Add')
                    ),
                    TextButton.icon(
                      onPressed: (){
                        if (user.dataBase.isNotEmpty) {
                          Navigator.of(context).pushNamed('/view');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              action: SnackBarAction(
                                label: 'Ok', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()
                              ),
                              content: const Text(
                                'Oops!!! seems like you currently have no Todos to view. Add Todos first',
                                style: TextStyle(
                                  fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 15,
                                  color: Colors.white
                                )
                              ), 
                              backgroundColor: const Color.fromARGB(255, 75, 9, 4), duration: const Duration(seconds: 5), elevation: 20,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                              ),                              
                            )
                          );
                        }
                      },
                      icon: const Icon(Icons.view_array),
                      label: const Text('View')
                    ),
                    TextButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.delete),
                      label: Text('Delete')
                    ),
                    TextButton.icon(
                      onPressed: (){},
                      icon: Icon(Icons.update_sharp),
                      label: Text('Update')
                    ),
                  ]
                )
              ]
            ),
          )
        )
      )
    );
  }
}