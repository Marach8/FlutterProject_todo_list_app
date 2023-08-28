import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/todo_provider.dart';

class AddUpdate extends StatefulWidget{
  const AddUpdate({super.key});

  @override 
  State<AddUpdate> createState() => _AU();
}

class _AU extends State<AddUpdate> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();  

  Future <void> dialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        //Future.delayed(const Duration(seconds:2), () => Navigator.of(context).pop());
        return AlertDialog(
          title: const Text(
            'Save Todo',
            style: TextStyle(
              fontFamily: 'monospace', color: Colors.white70,
              fontSize: 20, fontWeight: FontWeight.bold,
            )
          ),
          content: const Text(
            'Todo has been saved sucessfully. Do you want to add another?',
            style: TextStyle(
              fontFamily: 'monospace', color: Colors.white70,
              fontSize: 20, fontWeight: FontWeight.bold,
            )
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                controller1.clear(); controller2.clear(); controller3.clear();
              }, 
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontFamily: 'monospace', color: Colors.white70,
                  fontSize: 20, fontWeight: FontWeight.bold,
                )
              )
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
                controller1.clear(); controller2.clear(); controller3.clear();
                Navigator.of(context).pop();
              }, 
              child: const Text(
                'No',
                style: TextStyle(
                  fontFamily: 'monospace', color: Colors.white70,
                  fontSize: 20, fontWeight: FontWeight.bold,
                )
              )
            )
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        );
      }      
    );
  }

  @override 
  void dispose(){
    controller1.dispose(); controller2.dispose(); controller3.dispose(); super.dispose();
  }
  
  @override 
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    bool hasData = [controller1, controller2, controller3].every((controller) => controller.text.isNotEmpty);
    
    return Consumer<User>(
      builder: (context, user, child)
      => Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text(
            'Add the details of your todo here',
            style: TextStyle(fontFamily: 'sans serif', color:Colors.grey)
          )
        ),
        backgroundColor: Colors.white38,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius:10, spreadRadius: 10)
                    ]
                  ),
                  child: SingleChildScrollView(
                    child: TextField( 
                      controller: controller1,
                      maxLines: null, autocorrect: true, 
                      cursorColor: Colors.blue,              
                      decoration: const InputDecoration(
                        border: InputBorder.none, focusedBorder: InputBorder.none,
                        fillColor: Colors.black, filled: true,
                        hintText: 'Title',
                        hintStyle: TextStyle(
                          fontFamily: 'monospace', color: Colors.white70,
                          fontSize: 20, fontWeight: FontWeight.bold,
                        )               
                      ), 
                      style: const TextStyle(
                        fontSize: 20, color: Colors.blueAccent,
                        decoration: TextDecoration.none, fontFamily: 'monospace'
                      )
                    ),
                  ),
                ),
        
                Container(
                  padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius:10, spreadRadius: 10)
                    ]
                  ),
                  child: SingleChildScrollView(
                    child: TextField( 
                      controller: controller2,
                      maxLines: null, autocorrect: true, 
                      cursorColor: Colors.blue,              
                      decoration: const InputDecoration(
                        border: InputBorder.none, focusedBorder: InputBorder.none,
                        fillColor: Colors.black, filled: true,
                        hintText: 'Date/Time',
                        hintStyle: TextStyle(
                          fontFamily: 'monospace', color: Colors.white70,
                          fontSize: 20, fontWeight: FontWeight.bold,
                        )
                      ),
                      style: const TextStyle(
                        fontSize: 20, color: Colors.deepOrangeAccent,
                        decoration: TextDecoration.none, fontFamily: 'monospace'
                      )
                    ),
                  ),
                ),
        
                Container(
                  padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(blurRadius:10, spreadRadius: 10)
                    ]
                  ),
                  child: SingleChildScrollView(
                    child: TextField( 
                      controller: controller3,
                      maxLines: null, autocorrect: true, 
                      cursorColor: Colors.blue,              
                      decoration: const InputDecoration(
                        border: InputBorder.none, focusedBorder: InputBorder.none,
                        fillColor: Colors.black, filled: true,
                        hintText: 'Content',
                        hintStyle: TextStyle(
                          fontFamily: 'monospace', color: Colors.white70,
                          fontSize: 20, fontWeight: FontWeight.bold,
                        )
                      ),
                      style: const TextStyle(
                        fontSize: 20, color: Colors.yellow,
                        decoration: TextDecoration.none, fontFamily: 'monospace'
                      )
                    ),
                  ),
                ),
        
                SizedBox(height: h*0.01),
            
                ElevatedButton.icon(
                  onPressed: () async{
                    if(hasData){
                      user.addTodo(controller1.text, controller2.text, controller3.text);
                      await dialogBox();                      
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          action: SnackBarAction(
                            label: 'Ok', onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar()
                          ),
                          content: const Text(
                            'Oops!!! Please fill in all the textfields!',
                            style: TextStyle(
                              fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 15,
                              color: Colors.white
                            )
                          ), 
                          backgroundColor: Colors.red.shade900, duration: const Duration(seconds: 5), elevation: 20,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),                              
                        )
                      );
                    }
                  },
                  icon: const Icon(Icons.save_sharp),
                  label: const Text(
                    'Save Todo',
                    style: TextStyle(
                      fontFamily: 'monospace', fontWeight: FontWeight.bold, fontSize: 20,                    
                    )
                  ),
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(20),
                    shadowColor: const MaterialStatePropertyAll(Color.fromARGB(255, 198, 160, 19)),
                    backgroundColor: const MaterialStatePropertyAll(Colors.black),                  
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),                    
                    ),
                    side: const MaterialStatePropertyAll(
                      BorderSide(color: Colors.blue, strokeAlign: 3, width: 3)
                    ),
                    fixedSize: MaterialStatePropertyAll(Size(w*0.8, w*0.15))
                  ),
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}