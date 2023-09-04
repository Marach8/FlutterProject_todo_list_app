import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/todo_provider.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override 
  State<LoginPage> createState() => _Login();
}

class _Login extends State<LoginPage> {
  bool forgotPassword = false; bool isRegistered = true;
  
    Widget textField(bool enabled, Color color, String hintText){
    return  Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), 
      decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(blurRadius:3, spreadRadius: 1, color: Colors.black)],                            
      ),
      child: SingleChildScrollView(
        child: TextField(
          enabled: enabled,
          maxLines: null, 
          autocorrect: true, cursorColor: Colors.black,
          style: GoogleFonts.getFont('Quicksand', color: Colors.black, fontWeight: FontWeight.w700,), 
          decoration: InputDecoration(
            border: InputBorder.none, hintText: hintText,
            hintStyle: GoogleFonts.getFont('Nunito', color: Colors.black45, fontWeight: FontWeight.w500,),
          ),
        ),
      ),
    );
  }

  Widget text(textItem, double fontSize, FontWeight font, Color color,){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(textItem, style: GoogleFonts.getFont('Quicksand', fontWeight: font, color: color, fontSize: fontSize)),
    );
  }

  String appBarText(){
    if(isRegistered && !forgotPassword){return 'User Login';} 
    else if (isRegistered && forgotPassword){return 'User Password Reset';}
    else if (!isRegistered && !forgotPassword){return 'User Registration';} 
    else {return '';}
  }

  @override
  Widget build(BuildContext context){
    
    var w = MediaQuery.of(context).size.width;

    return Consumer<User>(
      builder: ((context, user, child) =>
        Scaffold(
          appBar: AppBar(
            title: Text(appBarText()), centerTitle: true,
            backgroundColor: Colors.white, elevation: 10, foregroundColor: Colors.black,
          ),
          backgroundColor: forgotPassword? Colors.white24: Colors.white,
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(                    
                      margin: const EdgeInsets.only(left: 20, right: 20), padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      decoration: BoxDecoration(
                        color: Colors.white70, borderRadius: BorderRadius.circular(10),
                        boxShadow: const [BoxShadow(blurRadius: 10, spreadRadius:1, color: Colors.black38)]                      
                      ),
                      child: Column(
                        children: [                          
                          text(isRegistered? 'Sign In': 'Sign Up', 25, FontWeight.w800, Colors.green.shade900),
                          const SizedBox(height: 10), const Divider(height:1, color: Colors.green), const SizedBox(height:10),
                          !isRegistered? Row(children:[text('Username', 15, FontWeight.w600, Colors.black45)])
                          : const SizedBox(), 
                          !isRegistered? textField(true, Colors.white, ''): const SizedBox(), 
                          Row(children:[text('Mobile number or email', 15, FontWeight.w600, Colors.black45)]), 
                          textField(forgotPassword? false: true, Colors.white, ''), 
                          Row(children:[text('Password', 15, FontWeight.w600, Colors.black45)]), 
                          textField(forgotPassword? false : true, Colors.white, ''), 
                          SizedBox(
                            height: 40,
                            child: Stack(                        
                              children:[
                                Positioned(left: 0, 
                                  child: !isRegistered? const SizedBox(): GestureDetector(
                                    onTap: (){
                                      setState(() => forgotPassword = true);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.only(topLeft:Radius.circular(20), topRight: Radius.circular(20),)
                                          ),
                                          backgroundColor: Colors.blueGrey.shade700, duration: const Duration(days: 1),
                                          content: Container(
                                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                            decoration: BoxDecoration(
                                              color: Colors.white70, borderRadius: BorderRadius.circular(10),
                                              boxShadow: const [BoxShadow(blurRadius: 10, spreadRadius:1, color: Colors.black54)]                      
                                            ),
                                            child: Column(
                                              children: [
                                                text('Password Reset', 20, FontWeight.w800, Colors.black,), 
                                                const SizedBox(height:20),const Divider(height: 1), const SizedBox(height:20),
                                                textField(true, Colors.blueGrey.shade300, 'Enter mobile number or email'), 
                                                const SizedBox(height:30), textField(true, Colors.blueGrey.shade300, 'Enter new password'), 
                                                const SizedBox(height:20),const Divider(height: 1), const SizedBox(height:20), 
                                                ElevatedButton(
                                                  onPressed: (){
                                                    setState(() => forgotPassword = false);
                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                  },                          
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStatePropertyAll(Colors.green.shade300),
                                                    fixedSize: MaterialStatePropertyAll(Size(w, 30)),
                                                    side: const MaterialStatePropertyAll(BorderSide(width: 1, strokeAlign: 3, color: Colors.black))
                                                  ),
                                                  child: text('Change Password', 15, FontWeight.w700, Colors.black)
                                                ),
                                              ],
                                            ),
                                          )
                                        )
                                      );
                                    },
                                    child: text('Forgot Password?', 13, FontWeight.w800, Colors.blueGrey.shade700,)
                                  )
                                ),
                                Positioned(right: 0, 
                                  child: GestureDetector(
                                    onTap: (){
                                      setState(() => isRegistered = !isRegistered);
                                    },
                                    child: text(isRegistered? 'Not Registered?': 'Already Registered?', 13, FontWeight.w800, Colors.blueGrey.shade700,)
                                  )
                                ),
                              ] 
                            ),
                          ),
                          const SizedBox(height: 25), const Divider(height:1, color: Colors.green), const SizedBox(height: 25),
                          ElevatedButton(
                            onPressed: (){},                          
                            style: ButtonStyle(
                              fixedSize: MaterialStatePropertyAll(Size(w, 30)),
                              side: const MaterialStatePropertyAll(BorderSide(width: 1, strokeAlign: 3, color: Colors.green))
                            ),
                            child: text(isRegistered? 'Login': 'Register', 15, FontWeight.w700, Colors.green)
                          )
                        ],
                      )
                    ),
                  )
                ]
              )
            )
          )
        )
      ) ,
    );
  }
}