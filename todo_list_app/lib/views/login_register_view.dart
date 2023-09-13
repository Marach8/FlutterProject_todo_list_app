import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  bool forgotPassword = false; bool isRegistered = true; 
  
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
                          TextItem().textItem(isRegistered? 'Sign In': 'Sign Up', 25, FontWeight.w800, Colors.green.shade900),
                          const SizedBox(height: 10), const Divider(height:1, color: Colors.green), const SizedBox(height:10),
                          !isRegistered? Row(children:[TextItem().textItem('Username', 15, FontWeight.w600, Colors.black45)])
                          : const SizedBox(), 
                          !isRegistered? TextFields1().textField(true, Colors.white, '', user.usernameController, false): const SizedBox(), 
                          Row(children:[TextItem().textItem('Mobile number or email', 15, FontWeight.w600, Colors.black45)]), 
                          TextFields1().textField(forgotPassword? false: true, Colors.white, '', user.mobileEmailController, false), 
                          Row(children:[TextItem().textItem('Password', 15, FontWeight.w600, Colors.black45)]), 
                          TextFields1().textField(forgotPassword? false : true, Colors.white, '', user.passwordController, true),
                          !isRegistered? Row(children:[TextItem().textItem('Confirm password', 15, FontWeight.w600, Colors.black45)])
                          : const SizedBox(), 
                          !isRegistered? TextFields1().textField(true, Colors.white, '', user.confirmPassController, true): const SizedBox(),
                          SizedBox(
                            height: 40,
                            child: Stack(                        
                              children:[
                                Positioned(left: 0, 
                                  child: !isRegistered? const SizedBox(): GestureDetector(
                                    onTap: (){
                                      user.mobileEmailController.clear(); user.passwordController.clear(); 
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
                                                              user.controllerA.clear(); user.controllerB.clear();
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
                                                TextFields1().textField(
                                                  true, Colors.blueGrey.shade300, 'Enter mobile number or email', user.controllerA, false
                                                ), 
                                                const SizedBox(height:30), 
                                                TextFields1().textField(true, Colors.blueGrey.shade300, 'Enter new password', user.controllerB, true), 
                                                const SizedBox(height:20),const Divider(height: 1), const SizedBox(height:20), 
                                                ElevatedButton(
                                                  onPressed: () async{
                                                    bool passwordResetFields = [user.controllerA, user.controllerB].every(
                                                      (controller) => controller.text.isNotEmpty
                                                    );                                                    
                                                    if(passwordResetFields){
                                                      ProgressIndicatorDialog().alert(context);
                                                      if(user.dataBase.containsKey(user.controllerA.text)){
                                                        user.dataBase[user.controllerA.text]![1] == user.controllerB.text;
                                                        await Future.delayed(const Duration(seconds: 3), () {
                                                          Navigator.of(context).pop();
                                                          MaterialBannerAlert1(context).materialBannerAlert1(
                                                            'Password Changed!!!', Colors.green, Icons.check
                                                          );
                                                        });
                                                        await Future.delayed(const Duration(seconds: 2), (){
                                                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                                                          user.controllerA.clear(); user.controllerB.clear();
                                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                        });
                                                        setState(() => forgotPassword = false);
                                                      } else {
                                                        await Future.delayed(const Duration(seconds: 3), () {
                                                          Navigator.of(context).pop();
                                                          MaterialBannerAlert1(context).materialBannerAlert1(
                                                            'User "${user.controllerA.text}" not found!!!', Colors.red, Icons.warning_rounded
                                                          );
                                                        });
                                                        await Future.delayed(const Duration(seconds: 2), (){
                                                          ScaffoldMessenger.of(context).hideCurrentMaterialBanner();                                                        
                                                        });
                                                      }
                                                    } else{
                                                      MaterialBannerAlert1(context).materialBannerAlert1(
                                                        'Fields Cannot be Empty!!!', Colors.red, Icons.warning_rounded
                                                      );
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
                                      user.mobileEmailController.clear(); user.passwordController.clear(); 
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
                              bool loginFields = [user.mobileEmailController, user.passwordController]
                              .every((controller) => controller.text.isNotEmpty);
                              if(isRegistered){
                                if(loginFields) {
                                  ProgressIndicatorDialog().alert(context);
                                  await FirebaseAuthLogin().firebaseLogin(
                                    user.mobileEmailController.text.trim(), user.passwordController.text.trim(),
                                    (text, color, icon) async{
                                      Navigator.of(context).pop();
                                      await MaterialBannerAlert1(context).materialBannerAlert1(text, color, icon);
                                    } 
                                  ).then((result) async{
                                    if(result == 'yes'){
                                     String finalUser = await FirebaseCurentUser().getCurrentUser();
                                      user.loggedInUser = finalUser;
                                      print(user.loggedInUser);
                                      user.mobileEmailController.clear(); user.passwordController.clear();
                                      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                                  } else if(result == 'no'){
                                    await MaterialBannerAlert1(context).materialBannerAlert1(
                                      "Couldn't Login!!!", Colors.red, Icons.close_rounded
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
                                bool registrationFields = [user.mobileEmailController, user.passwordController,
                                user.confirmPassController, user.usernameController].every((controller) => controller.text.isNotEmpty);
                                if(registrationFields){
                                  ProgressIndicatorDialog().alert(context);
                                  if(user.passwordController.text == user.confirmPassController.text){
                                    await FirebaseAuthRegister().firebaseRegister(
                                      user.usernameController.text.trim(),
                                      user.mobileEmailController.text.trim(), user.passwordController.text.trim(),
                                      (text, color) async {
                                        Navigator.of(context).pop();
                                        await MaterialBannerAlert1(context).materialBannerAlert1(text, color, Icons.warning_rounded);
                                      } 
                                    );
                                    user.mobileEmailController.clear(); user.passwordController.clear(); 
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
                                    'Fields Cannot be Empty!!!', Colors.red, Icons.warning_rounded
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