import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
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
  bool forgotPassword = false; 
  bool isRegistered = true; 
  bool obscureText1 = true;
  
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
      builder: ((_, user, __) =>
        Scaffold(
          appBar: AppBar(
            title: Text(
              appBarText(), 
              style: const TextStyle(fontWeight: fontWeight1)
            ), 
            centerTitle: true,
            backgroundColor: forgotPassword? Colors.blueGrey.shade700: blackColor, 
            elevation: 10, 
            foregroundColor: whiteColor
          ),
          backgroundColor: forgotPassword ? Colors.white24: whiteColor,
          body: Container(
            decoration: const BoxDecoration(
              color: blackColor
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Container(                    
                  margin: const EdgeInsets.only(left: 20, right: 20), 
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  decoration: BoxDecoration(                    
                    color: Colors.white70, 
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 10, 
                        spreadRadius:1, 
                        color: Colors.black38
                      )
                    ]
                  ),
                  child: Column(
                    children: [                          
                      TextItem(
                        text: isRegistered ? 'Sign In': 'Sign Up', 
                        fontSize: fontSize2, 
                        fontWeight: fontWeight2, 
                        color: deepGreenColor
                      ),
                      const Gap(10),
                      const Divider(height: 1, color: greenColor), 
                      const Gap(10),

                      !isRegistered ? const TextItem(
                        text: 'Username', 
                        fontSize: fontSize1, 
                        fontWeight: fontWeight1,
                        color: blackColor
                      ) : const SizedBox.shrink(),
                      
                      !isRegistered ? LoginAndSignUpTextFields(
                        color: whiteColor,
                        enabled: true,
                        controller: user.usernameController,
                      ): const SizedBox(), 
                      
                      const TextItem(
                        text: 'Email', 
                        fontSize: fontSize1, 
                        fontWeight: fontWeight1,
                        color: blackColor
                      ), 
                      
                      LoginAndSignUpTextFields(
                        color: whiteColor,
                        enabled: forgotPassword ? false : true,
                        controller: user.emailController,
                      ),
                      
                      const TextItem(
                        text: 'Password', 
                        fontSize: fontSize1, 
                        fontWeight: fontWeight1,
                        color: blackColor
                      ),
                      
                      LoginAndSignUpTextFields(
                        showSuffixIcon: true,
                        color: whiteColor,
                        enabled: forgotPassword ? false : true,                        
                        controller: user.passwordController,
                      ),
                      
                      !isRegistered ? const TextItem(
                        text: 'Confirm Password', 
                        fontSize: fontSize1, 
                        fontWeight: fontWeight1,
                        color: blackColor
                      ) : const SizedBox.shrink(),
                      
                    
                      !isRegistered ? LoginAndSignUpTextFields(
                        showSuffixIcon: true,
                        color: whiteColor,
                        enabled: true,                        
                        controller: user.confirmPassController,
                      ) : const SizedBox(),

                      SizedBox(
                        height: 40,
                        child: Stack(
                          children:[
                            Positioned(left: 0, 
                              child: !isRegistered ? const SizedBox(): GestureDetector(
                                onTap: (){
                                  user.emailController.clear(); 
                                  user.passwordController.clear(); 
                                  setState(() => forgotPassword = true);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft:Radius.circular(20), 
                                          topRight: Radius.circular(20),
                                        )
                                      ),
                                      backgroundColor: Colors.blueGrey.shade700, 
                                      duration: const Duration(days: 1),
                                      content: Container(
                                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                        decoration: BoxDecoration(
                                          color: Colors.white70, 
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(blurRadius: 10, spreadRadius:1, color: Colors.black54)
                                          ]                      
                                        ),
                                        child: Column(
                                          children: [
                                            Stack(
                                              children: [
                                                const TextItem(
                                                  text: 'Password Reset', 
                                                  fontSize: fontSize2, 
                                                  fontWeight: fontWeight1,
                                                  color: blackColor
                                                ),
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
                                                        }, 
                                                        icon: const Icon(
                                                          Icons.arrow_downward_rounded, color: Colors.black
                                                        )
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ]
                                            ),
                                            const SizedBox(height:20),
                                            const Divider(height: 1), const SizedBox(height:20),
                                            LoginAndSignUpTextFields(
                                              showSuffixIcon: true,
                                              color: whiteColor,
                                              enabled: forgotPassword ? false : true,                        
                                              controller: user.passwordController,
                                            ), 
                                            const Gap(20),
                                            const Divider(height: 1), 
                                            const Gap(20),
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
                                                    'Fields Cannot be Empty!!!',
                                                    Colors.red, Icons.warning_rounded
                                                  );
                                                }                                                    
                                              },                          
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.green.shade300),
                                                fixedSize: MaterialStatePropertyAll(Size(w, 30)),
                                                side: const MaterialStatePropertyAll(
                                                  BorderSide(width: 1, strokeAlign: 3, color: Colors.black)
                                                )
                                              ),
                                              child: const TextItem(
                                                text: 'Change Password', 
                                                fontSize: fontSize1, 
                                                fontWeight: fontWeight2,
                                                color: blackColor
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    )
                                  );
                                },
                                child: const TextItem(
                                  text: 'Forgort Password', 
                                  fontSize: fontSize1, 
                                  fontWeight: fontWeight2,
                                  color: blackColor
                                ),
                                        )
                            ),
                            Positioned(right: 0, 
                              child: GestureDetector(
                                onTap: (){
                                  user.emailController.clear(); 
                                  user.passwordController.clear(); 
                                  user.usernameController.clear(); 
                                  user.confirmPassController.clear();
                                  setState(() => isRegistered = !isRegistered);
                                },
                                child: TextItem(
                                  text: isRegistered? 'Not Registered?': 'Already Registered?',
                                  fontSize: fontSize1, 
                                  fontWeight: fontWeight2,
                                  color: blackColor
                                ),
                              )
                            ),
                          ] 
                        ),
                      ),
                      const Gap(20), 
                      const Divider(height:1, color: Colors.green), 
                      const Gap(20),
                      ElevatedButton(
                        onPressed: () async{
                
                          //user Login
                          bool loginFields = [
                            user.emailController, user.passwordController
                          ]
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
                            bool registrationFields = [
                              user.emailController, 
                              user.passwordController,
                              user.confirmPassController, 
                              user.usernameController
                            ]
                            .every((controller) => controller.text.isNotEmpty);
                            if(registrationFields){
                              ProgressIndicatorDialog().alert(context, 'Please Wait...');
                              if(user.passwordController.text == user.confirmPassController.text){
                                await FirebaseAuthRegister().firebaseRegister(
                                  user.usernameController.text.trim(),
                                  user.emailController.text.trim(), 
                                  user.passwordController.text.trim(),
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
                          side: const MaterialStatePropertyAll(
                            BorderSide(width: 1, strokeAlign: 3, color: Colors.green)
                          )
                        ),
                        child: TextItem(
                          text: isRegistered? 'Login': 'Register', 
                          fontSize: fontSize1, 
                          fontWeight: fontWeight2,
                          color: greenColor
                        ),
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