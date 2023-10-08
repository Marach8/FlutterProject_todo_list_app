import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/textfield_widget.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class AddUpdate extends StatefulWidget{
  const AddUpdate({super.key});

  @override 
  State<AddUpdate> createState() => _AU();
}

class _AU extends State<AddUpdate> {
  TextEditingController control = TextEditingController();

  @override 
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;    
    
    return Consumer<AppUsers>(
      builder: (context, user, child)
      => Scaffold(
        appBar: AppBar(centerTitle: true, title: Text(
            'Add the details of your todo here', style: GoogleFonts.getFont('Nunito', color:Colors.white, fontSize: 17)
          )
        ),
        backgroundColor: Colors.blueGrey.shade900,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddTodoTextFields().addTodoTextFields(
                  'Title', user.todoTitleController,
                  (newTitle){
                    if(user.isInUpdateMode){
                      if (newTitle != user.initialTitle){
                        user.wasteBin.add([user.initialTitle, user.initialDate, user.initialTodo]);                        
                        for(List item in user.wasteBin){
                          FirestoreInteraction().deleteTodo(user.firebaseCurrentUser!.uid, item[0]);
                        }
                      }
                    }                  
                  }
                ), 
                AddTodoTextFields().addTodoTextFields('Date/Time', user.todoDateTimeController, null), 
                AddTodoTextFields().addTodoTextFields('Content', user.todoContentController, null),
        
                SizedBox(height: h*0.02),
            
                ElevatedButton.icon(
                  onPressed: () async{
                    bool hasData = [user.todoTitleController, user.todoDateTimeController, user.todoContentController].every((controller) => controller.text.isNotEmpty);
                    if(hasData){
                      if(user.isInUpdateMode){
                        user.addTodo(user.updateIndex); 
                        if(user.dataBase.isNotEmpty){                      
                          for(List item in user.dataBase){
                            FirestoreInteraction().createTodo(
                              user.firebaseCurrentUser!.uid, item[0], {'title': item[0], 'datetime': item[1], 'content': item[2]}
                            );                        
                          }                          
                        }
                        user.isInUpdateMode = false;
                      } 
                      else{
                        user.addTodo(user.dataBase.length);
                        if(user.dataBase.isNotEmpty){                      
                          for(List item in user.dataBase){
                            FirestoreInteraction().createTodo(
                              user.firebaseCurrentUser!.uid, item[0], {'title': item[0], 'datetime': item[1], 'content': item[2]}
                            );                        
                          }                          
                        }
                      }
                      await DialogBox(context: context).dialogBox(
                        user.todoTitleController, user.todoDateTimeController, user.todoContentController
                      );                      
                    } else {
                      SnackBarAlert(context: context).snackBarAlert('Oops!!! Fields cannot be empty!');                      
                    }
                  },
                  icon: Icon(Icons.save_sharp, color: Colors.blueGrey.shade400),
                  label: Text(
                    'Save Todo',
                    style: GoogleFonts.getFont('Nunito', fontWeight: FontWeight.bold, fontSize: 20, color: Colors.blueGrey.shade400)
                  ),
                  style: ButtonStyle(
                    elevation: const MaterialStatePropertyAll(20),
                    shadowColor: const MaterialStatePropertyAll(Colors.blue),
                    backgroundColor: MaterialStatePropertyAll(Colors.blueGrey.shade900),                  
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),                    
                    ),
                    side: MaterialStatePropertyAll(
                      BorderSide(color: Colors.blueGrey.shade600, strokeAlign: 3, width: 1)
                    ),
                    fixedSize: MaterialStatePropertyAll(Size(w*0.91, w*0.13))
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