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
  
    Widget textField(bool enabled, Color color, String hintText, TextEditingController controller){
    return  Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0), 
      decoration: BoxDecoration(
        color: color, borderRadius: BorderRadius.circular(30),
        boxShadow: const [BoxShadow(blurRadius:3, spreadRadius: 1, color: Colors.black)],                            
      ),
      child: SingleChildScrollView(
        child: TextField(
          controller: controller,
          enabled: enabled,
          maxLines: null, 
          autocorrect: true, cursorColor: Colors.black,
          style: GoogleFonts.getFont('Quicksand', color: Colors.blueGrey.shade900, fontWeight: FontWeight.w500,), 
          decoration: InputDecoration(
            border: InputBorder.none, hintText: hintText,
            hintStyle: GoogleFonts.getFont('Nunito', color: Colors.black45, fontWeight: FontWeight.w500,),
          ),
        ),
      ),
    );
  }

  Future<void> alert(BuildContext context){
    return showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        content:  LinearProgressIndicator(),
        title: Text('Please Wait...'),
      )
    );
  }

  snackBarAlert(String text, Color color, IconData icon){
    return ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        leading: Icon(icon, color: color, size:40), backgroundColor: Colors.blueGrey.shade800,
        content: Text(text, style: GoogleFonts.getFont('Nunito', fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white)), 
        actions: [
          TextButton(onPressed: (){}, 
          child: const Text('Ok')
          )
        ]
      )
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
                          !isRegistered? textField(true, Colors.white, '', user.usernameController): const SizedBox(), 
                          Row(children:[text('Mobile number or email', 15, FontWeight.w600, Colors.black45)]), 
                          textField(forgotPassword? false: true, Colors.white, '', user.mobileEmailController), 
                          Row(children:[text('Password', 15, FontWeight.w600, Colors.black45)]), 
                          textField(forgotPassword? false : true, Colors.white, '', user.passwordController),
                          !isRegistered? Row(children:[text('Confirm password', 15, FontWeight.w600, Colors.black45)])
                          : const SizedBox(), 
                          !isRegistered? textField(true, Colors.white, '', user.confirmPassController): const SizedBox(),
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
                                                Stack(
                                                  children: [
                                                    Center(child: text('Password Reset', 20, FontWeight.w800, Colors.black,),),
                                                    Positioned(
                                                      right:0,
                                                      child: Container(
                                                        width:45,
                                                        decoration: BoxDecoration(
                                                          color: Colors.green.shade300,
                                                          shape: BoxShape.circle,                                                          
                                                          border: Border.all(width:1)
                                                        ),
                                                        child: Center(
                                                          child: IconButton(
                                                            onPressed: () {
                                                              ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                              setState(() => forgotPassword = false);
                                                            }, icon: const Icon(Icons.arrow_downward_rounded, color: Colors.black)
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ]
                                                ),
                                                const SizedBox(height:20),const Divider(height: 1), const SizedBox(height:20),
                                                textField(true, Colors.blueGrey.shade300, 'Enter mobile number or email', user.controllerA), 
                                                const SizedBox(height:30), 
                                                textField(true, Colors.blueGrey.shade300, 'Enter new password', user.controllerB), 
                                                const SizedBox(height:20),const Divider(height: 1), const SizedBox(height:20), 
                                                ElevatedButton(
                                                  onPressed: () async{
                                                    bool passwordResetFields = [user.controllerA, user.controllerB].every((controller) => controller.text.isNotEmpty);                                                    
                                                    if(passwordResetFields){
                                                      alert(context);
                                                      if(user.dataBase.containsKey(user.controllerA.text)){
                                                        user.dataBase[user.controllerA.text]![1] == user.controllerB.text;
                                                        await Future.delayed(const Duration(seconds: 3), () {
                                                          Navigator.of(context).pop();
                                                          snackBarAlert('Password Changed!!!', Colors.green, Icons.check);
                                                        });
                                                        await Future.delayed(const Duration(seconds: 2), (){
                                                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                        });
                                                        setState(() => forgotPassword = false);
                                                      } else {
                                                        await Future.delayed(const Duration(seconds: 3), () {
                                                          Navigator.of(context).pop();
                                                          snackBarAlert('User "${user.controllerA.text}" not found!', Colors.red, Icons.warning_rounded);
                                                        });
                                                        await Future.delayed(const Duration(seconds: 2), (){
                                                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();                                                        
                                                        });
                                                      }
                                                    } else{
                                                      snackBarAlert('Fields Cannot be Empty!!!', Colors.red, Icons.warning_rounded);
                                                      await Future.delayed(const Duration(seconds: 2), () =>
                                                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner()                                                       
                                                      );
                                                    }                                                    
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
                            onPressed: () async{
                              //user Login
                              bool loginFields = [user.mobileEmailController, user.passwordController]
                              .every((controller) => controller.text.isNotEmpty);
                              if(isRegistered){
                                if(loginFields){
                                  alert(context);
                                  if(user.dataBase.containsKey(user.mobileEmailController.text) &&
                                    (user.passwordController.text == user.dataBase[user.mobileEmailController.text]![1])){
                                      user.login(user.mobileEmailController.text);                                  
                                      await Future.delayed(const Duration(seconds: 3), () {
                                        Navigator.of(context).pop(); snackBarAlert('Login Successful...', Colors.green, Icons.check);
                                      });
                                      await Future.delayed(const Duration(seconds: 2), () {
                                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                                      });
                                    } else {
                                      await Future.delayed(const Duration(seconds: 3), () {
                                        Navigator.of(context).pop(); snackBarAlert('Invalid Login Credentials!!!', Colors.red, Icons.warning_rounded);
                                      });
                                      await Future.delayed(const Duration(seconds: 2), () =>
                                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                                      );
                                    }
                                } else{
                                  snackBarAlert('Fields Cannot be Empty!!!', Colors.red, Icons.warning_rounded);
                                  await Future.delayed(const Duration(seconds: 2), () =>
                                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                                  );
                                }                                
                              }
                              //User Registration
                              else {
                                bool registrationFields = [user.mobileEmailController, user.passwordController,
                                user.confirmPassController, user.usernameController].every((controller) => controller.text.isNotEmpty);
                                if(registrationFields){
                                  if(user.dataBase.containsKey(user.mobileEmailController.text)){
                                    alert(context);
                                    await Future.delayed(const Duration(seconds: 3), () {
                                      Navigator.of(context).pop(); snackBarAlert('User Already Exists!!!', Colors.red, Icons.warning_rounded);
                                    });
                                    await Future.delayed(const Duration(seconds: 2), () =>
                                      ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                                    );
                                  }                                 
                                  else {
                                    if(user.passwordController == user.confirmPassController){
                                      alert(context);
                                      user.register(user.mobileEmailController.text, user.usernameController.text, user.passwordController.text);
                                      await Future.delayed(const Duration(seconds: 3), () {
                                        Navigator.of(context).pop(); snackBarAlert('Registration Successful...', Colors.green, Icons.check);
                                      });
                                      await Future.delayed(const Duration(seconds: 2), () =>
                                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                                      );
                                      setState(() => isRegistered = true);
                                      user.mobileEmailController.clear(); user.passwordController.clear(); user.usernameController.clear();
                                      user.confirmPassController.clear();
                                    } else{
                                      snackBarAlert('Password Confirmation Error!!!', Colors.red, Icons.warning_rounded);
                                      await Future.delayed(const Duration(seconds: 2), () =>
                                        ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                                      );
                                    }                                    
                                  }
                                } else{
                                  snackBarAlert('Fields Cannot be Empty!!!', Colors.red, Icons.warning_rounded);
                                  await Future.delayed(const Duration(seconds: 2), () =>
                                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                                  );
                                }                                
                              }
                            },                          
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