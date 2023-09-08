import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class AddUpdate extends StatefulWidget{
  const AddUpdate({super.key});

  @override 
  State<AddUpdate> createState() => _AU();
}

class _AU extends State<AddUpdate> {
  TextEditingController control = TextEditingController();

  Widget textFields(String text, TextEditingController control){
    return Container(
      padding: const EdgeInsets.all(10), margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [BoxShadow(blurRadius:10, spreadRadius: 10)]
      ),
      child: SingleChildScrollView(
        child: TextField( 
          controller: control,
          maxLines: null, autocorrect: true, 
          cursorColor: Colors.blue,              
          decoration: InputDecoration(
            border: InputBorder.none, focusedBorder: InputBorder.none,
            fillColor: Colors.black, filled: true,
            hintText: text,
            hintStyle: TextStyle(
              fontFamily: 'monospace', color: Colors.blueGrey.withOpacity(0.9),
              fontSize: 20, fontWeight: FontWeight.bold,
            )
          ),
          style: const TextStyle(
            fontSize: 20, color: Colors.white, decoration: TextDecoration.none, fontFamily: 'monospace'
          )
        ),
      ),
    );
  }

  Future <void> dialogBox(TextEditingController control1, TextEditingController control2,TextEditingController control3,){
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey.shade900,
          title: Text('Save Todo', style: GoogleFonts.getFont('Nunito', color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500,)),
          content: Text(
            'Todo has been saved sucessfully. Do you want to add another?',
            style: GoogleFonts.getFont('Nunito', color: Colors.white, fontSize: 15, fontWeight: FontWeight.w300,)
          ),
          actions: [
            TextButton(
              onPressed: (){Navigator.of(context).pop(); control1.clear(); control2.clear(); control3.clear();}, 
              child: Text('Yes', style: GoogleFonts.getFont('Nunito', color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w400,))
            ),
            TextButton(
              onPressed: () {
                control1.clear(); control2.clear(); control3.clear(); Navigator.of(context).popUntil(ModalRoute.withName('/home'));
              }, 
              child: Text('No', style: GoogleFonts.getFont('Nunito', color: Colors.blue, fontSize: 15, fontWeight: FontWeight.w400,))
            )
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
        );
      }      
    );
  }

  
  @override 
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;    
    
    return Consumer<User>(
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
                textFields('Title', user.controller1), textFields('Date/Time', user.controller2), textFields('Content', user.controller3),
        
                SizedBox(height: h*0.02),
            
                ElevatedButton.icon(
                  onPressed: () async{
                    bool hasData = [user.controller1, user.controller2, user.controller3].every((controller) => controller.text.isNotEmpty);
                    if(hasData){
                      user.addTodo();
                      await dialogBox(user.controller1, user.controller2, user.controller3);                      
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