import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/textfield_widget.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override 
  State<LoginPage> createState() => _Login();
}

class _Login extends State<LoginPage> {
  bool forgotPassword = false; bool isRegistered = true; bool obscureText1 = true;
  
  String appBarText(){
    if(isRegistered && !forgotPassword){return 'User Login';} 
    else if (isRegistered && forgotPassword){return 'User Password Reset';}
    else if (!isRegistered && !forgotPassword){return 'User Registration';} 
    else {return '';}
  }

  @override
  Widget build(BuildContext context){
    
    var w = MediaQuery.of(context).size.width; 

    return Consumer<AppUsers>(
      builder: ((context, user, child) =>
        Scaffold(
          appBar: AppBar(
            title: Text(appBarText()), centerTitle: true,
            backgroundColor: forgotPassword? Colors.blueGrey.shade700: Colors.white, elevation: 10, foregroundColor: Colors.black,
          ),
          backgroundColor: forgotPassword? Colors.white24: Colors.white,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.black45, Colors.black]
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Container(                    
                  margin: const EdgeInsets.only(left: 20, right: 20), padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  decoration: BoxDecoration(                    
                    color: Colors.white70, borderRadius: BorderRadius.circular(10),
                    boxShadow: const [BoxShadow(blurRadius: 10, spreadRadius:1, color: Colors.black38)]                      
                  ),
                  child: Column(
                    children: [                          
                      TextItem().textItem(isRegistered? 'Sign In': 'Sign Up', 25, FontWeight.w800, Colors.green.shade900),
                      const SizedBox(height: 10), const Divider(height:1, color: Colors.green), const SizedBox(height:10),
                      !isRegistered? Row(children:[TextItem().textItem('Username', 15, FontWeight.w600, Colors.black45)])
                      : const SizedBox(), 
                      !isRegistered? LoginAndSignUpTextFields().loginAndSignUpTextField(
                        null, true, Colors.white, '', user.usernameController, false,
                      ): const SizedBox(), 
                      Row(children:[TextItem().textItem('Email', 15, FontWeight.w600, Colors.black45)]), 
                      LoginAndSignUpTextFields().loginAndSignUpTextField(
                        null, forgotPassword? false: true, Colors.white, '', user.emailController, false,
                      ), 
                      Row(children:[TextItem().textItem('Password', 15, FontWeight.w600, Colors.black45)]), 
                      LoginAndSignUpTextFields().loginAndSignUpTextField(
                        IconButton(
                          onPressed: () => setState(()=> obscureText1 = !obscureText1),
                          icon: const Icon(Icons.remove_red_eye_sharp)
                        ),
                        forgotPassword? false : true, Colors.white, '', user.passwordController, obscureText1,                        
                      ),
                      !isRegistered? Row(children:[TextItem().textItem('Confirm password', 15, FontWeight.w600, Colors.black45)])
                      : const SizedBox(), 
                      !isRegistered? LoginAndSignUpTextFields().loginAndSignUpTextField(
                        IconButton(
                          onPressed: () => setState(() => obscureText1 = !obscureText1),
                          icon: const Icon(Icons.remove_red_eye_sharp)
                        ),
                        true, Colors.white, '', user.confirmPassController, obscureText1,                       
                      ): const SizedBox(),
                      SizedBox(
                        height: 40,
                        child: Stack(
                          children:[
                            Positioned(left: 0, 
                              child: !isRegistered? const SizedBox(): GestureDetector(
                                onTap: (){
                                  user.emailController.clear(); user.passwordController.clear(); 
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
                                                Center(child: TextItem().textItem('Password Reset', 20, FontWeight.w800, Colors.black,),),
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
                                                          user.forgotPasswordController.clear();
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
                                            LoginAndSignUpTextFields().loginAndSignUpTextField(
                                              null, true, Colors.blueGrey.shade300, 'Enter email', user.forgotPasswordController, false,
                                            ), 
                                            const SizedBox(height:20),const Divider(height: 1), const SizedBox(height:20), 
                                            ElevatedButton(
                                              onPressed: () async{                                                                                                        
                                                if(user.forgotPasswordController.text.isNotEmpty){
                                                  ProgressIndicatorDialog().alert(context, 'Please Wait...');
                                                  await FirebaseResetPassword().resetPassword(
                                                    user.forgotPasswordController.text,
                                                    (text, color, icon) async{
                                                      Navigator.of(context).pop();
                                                      await MaterialBannerAlert1(context).materialBannerAlert1(
                                                        text, color, icon
                                                      );
                                                    }
                                                   ).then((value) {
                                                    user.forgotPasswordController.clear();
                                                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                    setState(() => forgotPassword = false);
                                                  });
                                                } else{
                                                  MaterialBannerAlert1(context).materialBannerAlert1(
                                                    'Fields Cannot be Empty!!!', Colors.red, Icons.warning_rounded
                                                  );
                                                }                                                    
                                              },                          
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.green.shade300),
                                                fixedSize: MaterialStatePropertyAll(Size(w, 30)),
                                                side: const MaterialStatePropertyAll(BorderSide(width: 1, strokeAlign: 3, color: Colors.black))
                                              ),
                                              child: TextItem().textItem('Change Password', 15, FontWeight.w700, Colors.black)
                                            ),
                                          ],
                                        ),
                                      )
                                    )
                                  );
                                },
                                child: TextItem().textItem('Forgot Password?', 13, FontWeight.w800, Colors.blueGrey.shade700,)
                              )
                            ),
                            Positioned(right: 0, 
                              child: GestureDetector(
                                onTap: (){
                                  user.emailController.clear(); user.passwordController.clear(); 
                                  user.usernameController.clear(); user.confirmPassController.clear();
                                  setState(() => isRegistered = !isRegistered);
                                },
                                child: TextItem().textItem(
                                  isRegistered? 'Not Registered?': 'Already Registered?', 13, FontWeight.w800, Colors.blueGrey.shade700,
                                )
                              )
                            ),
                          ] 
                        ),
                      ),
                      const SizedBox(height: 25), const Divider(height:1, color: Colors.green), const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () async{
                
                          //user Login
                          bool loginFields = [user.emailController, user.passwordController]
                          .every((controller) => controller.text.isNotEmpty);
                          if(isRegistered){
                            if(loginFields) {
                              ProgressIndicatorDialog().alert(context, 'Please Wait...');
                              await FirebaseAuthLogin().firebaseLogin(
                                user.emailController.text.trim(), user.passwordController.text.trim(),
                                (text, color, icon) async{
                                  Navigator.of(context).pop();
                                  await MaterialBannerAlert1(context).materialBannerAlert1(text, color, icon);
                                } 
                              ).then((result) async{
                                if(result != 'no' && result != 'email not verified'){
                                  user.loggedInUser = result;
                                  user.emailController.clear(); user.passwordController.clear();
                                  Navigator.of(context).pushNamedAndRemoveUntil(homePageRoute, (route) => false);
                                } else if (result == 'email not verified'){
                                  await FirebaseEmailVerification().verifyEmail(
                                    (text, color, icon) async{
                                      Navigator.of(context).pop();
                                      await MaterialBannerAlert1(context).materialBannerAlert1(text, color, icon);
                                    }
                                  );
                                }
                              },);                                  
                            }  else{
                              MaterialBannerAlert1(context).materialBannerAlert1(
                                'Fields Cannot be Empty!!!', Colors.red, Icons.warning_rounded
                              );
                            }                               
                          }
                
                          //User Registration
                          else {
                            bool registrationFields = [user.emailController, user.passwordController,
                            user.confirmPassController, user.usernameController].every((controller) => controller.text.isNotEmpty);
                            if(registrationFields){
                              ProgressIndicatorDialog().alert(context, 'Please Wait...');
                              if(user.passwordController.text == user.confirmPassController.text){
                                await FirebaseAuthRegister().firebaseRegister(
                                  user.usernameController.text.trim(),
                                  user.emailController.text.trim(), user.passwordController.text.trim(),
                                  (text, color, icon) async {
                                    Navigator.of(context).pop();
                                    await MaterialBannerAlert1(context).materialBannerAlert1(text, color, icon);
                                  } 
                                ).then((registrationResult) async {
                                  registrationResult == 'yes'? await FirebaseEmailVerification().verifyEmail(
                                    (text, color, icon) async{                                      
                                      await MaterialBannerAlert1(context).materialBannerAlert1(text, color, icon);
                                    }
                                  ): {};
                                });
                                user.emailController.clear(); user.passwordController.clear(); 
                                user.usernameController.clear(); user.confirmPassController.clear();
                                setState(() => isRegistered = true);
                              } else {
                                Navigator.of(context).pop();
                                MaterialBannerAlert1(context).materialBannerAlert1(
                                  'Password Confirmation Error!!!', Colors.red, Icons.warning_rounded
                                );
                              }
                            } else{
                              MaterialBannerAlert1(context).materialBannerAlert1(
                                'Field(s) Cannot be Empty!!!', Colors.red, Icons.warning_rounded
                              );
                            }
                          }
                        },
                
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(w, 30)),
                          side: const MaterialStatePropertyAll(BorderSide(width: 1, strokeAlign: 3, color: Colors.green))
                        ),
                        child: TextItem().textItem(isRegistered? 'Login': 'Register', 15, FontWeight.w700, Colors.green)
                      ),
                    ],
                  )
                )
              )
            ),
          )
        )
      ) ,
    );
  }
}