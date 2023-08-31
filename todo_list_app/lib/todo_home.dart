import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
          //surfaceTintColor: Colors.blue.shade900,
          leading: Icon(icon, size: 40, color: Colors.blue,), elevation: 5,
          actions: [
            TextButton(
              onPressed:(){ScaffoldMessenger.of(context).hideCurrentMaterialBanner();}, 
              child: const Text(
                'Ok', style: TextStyle(fontFamily: 'monospace', fontSize: 20, fontWeight: FontWeight.w300, color: Colors.blue)
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
            label: 'Ok', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(), textColor: Colors.blue,
          ),
          content: Text(
            'Oops!!! seems like you currently have no Todos. Add Todos first!',
            style: GoogleFonts.getFont(
              'Nunito', fontWeight: FontWeight.w500, fontSize: 17,
              color: Colors.red.shade500
            )
          ), 
          backgroundColor: const Color.fromARGB(255, 40, 40, 46), duration: const Duration(seconds: 5), elevation: 20,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
          ),
        )
      );
    }

    Widget buttons(IconData icon, String text, VoidCallback function){
      return TextButton.icon(
        style: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(Colors.blueGrey.shade200)
        ),
        onPressed: function,
        icon: Icon(icon),
        label: Text(text, style: GoogleFonts.getFont('Nunito', fontSize: 17, fontWeight: FontWeight.w600,))
      );
    }
    
    return Consumer<User>(
      builder: ((context, user, child)
        => Scaffold(
          appBar: AppBar( 
            centerTitle: true, title: const Text('My Todo'),
            backgroundColor: const Color.fromARGB(255, 19, 19, 19), foregroundColor: Colors.blueGrey.shade300,          
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
                        color: Colors.blueGrey,
                        blurRadius: 10, spreadRadius: 1,
                      )
                    ],
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    'Hello, Welcome To Our Todo Manager.',
                    style: TextStyle(
                      fontFamily: 'monospace', fontSize: 45,
                      fontWeight: FontWeight.bold, color: Colors.blueGrey
                    )
                  )
                ),

                const SizedBox(height: 20),

                Wrap(
                  children: [
                    buttons(Icons.add, 'Add', () => Navigator.of(context).pushNamed('/add')),
                    buttons(
                      Icons.view_array, 'View', (){
                        if (user.dataBase.isNotEmpty) {
                          notify1('To view an item in detail, tap on the item.', Icons.view_array_rounded);
                          Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                          Navigator.of(context).pushNamed('/view');
                        } else {notify2();}
                      }
                    ),
                    buttons(
                      Icons.delete, 'Delete', (){
                        if (user.dataBase.isNotEmpty) {
                          notify1('To delete an item, swipe the item to the left or right.', Icons.delete);
                          Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                          Navigator.of(context).pushNamed('/view');
                        } else {notify2();}
                      }
                    ),
                    buttons(
                      Icons.update_rounded, 'Update', (){
                        if (user.dataBase.isNotEmpty) {
                          notify1('LongPress on the item you want to update to go to update mode.', Icons.update_sharp);
                          Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                          Navigator.of(context).pushNamed('/view');
                        } else {notify2();}
                      }
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