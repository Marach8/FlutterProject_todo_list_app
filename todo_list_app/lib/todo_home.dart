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

    void notify1(String text, IconData icon){
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          surfaceTintColor: Colors.blue.shade900,
          leading: Icon(icon, size: 40, color: Colors.blue,), elevation: 2,
          actions: [
            TextButton(
              onPressed:(){ScaffoldMessenger.of(context).hideCurrentMaterialBanner();}, 
              child: const Text(
                'Ok', style: TextStyle(fontFamily: 'monospace', fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue)
              )
            )
          ],
          backgroundColor: Colors.white, shadowColor: Colors.yellow, padding: const EdgeInsets.all(10),
          content: Text(
            text, 
            style: const TextStyle(
              fontFamily: 'monospace', fontSize: 15,
              fontWeight: FontWeight.bold, color: Colors.black
            )
          ),
        )
      );
    }

    void notify2(){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          action: SnackBarAction(
            label: 'Ok', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()
          ),
          content: const Text(
            'Oops!!! seems like you currently have no Todos. Add Todos first.',
            style: TextStyle(
              fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 15,
              color: Color.fromARGB(255, 195, 190, 251)
            )
          ), 
          backgroundColor: const Color.fromARGB(255, 40, 40, 46), duration: const Duration(seconds: 5), elevation: 20,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
        )
      );
    }
    
    return Consumer<User>(
      builder: ((context, user, child)
        => Scaffold(
          appBar: AppBar( 
            centerTitle: true, title: const Text('My Todo'),
            backgroundColor: const Color.fromARGB(255, 4, 4, 4),           
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: h*0.4,               
                  margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(221, 30, 30, 30),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 21, 21, 40),
                        blurRadius: 10, spreadRadius: 10,
                      )
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Hello, Welcome To Our Todo Manager.',
                    style: TextStyle(
                      fontFamily: 'monospace', fontSize: 45,
                      fontWeight: FontWeight.bold, color: Colors.black87
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
                        } else {notify2();}
                      },
                      icon: const Icon(Icons.view_array),
                      label: const Text('View')
                    ),
                    TextButton.icon(
                      onPressed: () {
                        if (user.dataBase.isNotEmpty) {
                          notify1('To delete, swipe the item you want to delete to the left or right.', Icons.delete);
                          Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                          Navigator.of(context).pushNamed('/view');
                        } else {notify2();}                        
                      },
                      icon: const Icon(Icons.delete),
                      label: const Text('Delete')
                    ),
                    TextButton.icon(
                      onPressed: () {
                        if (user.dataBase.isNotEmpty) {
                          notify1('LongPress on the item you want to update to go to update mode.', Icons.update_sharp);
                          Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                          Navigator.of(context).pushNamed('/view');
                        } else {notify2();}                        
                      },
                      icon: const Icon(Icons.update_sharp),
                      label: const Text('Update')
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