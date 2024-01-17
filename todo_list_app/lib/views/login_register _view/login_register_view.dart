import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/animations/slider_animations.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/textfield_widget.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';
import 'package:todo_list_app/views/login_register%20_view/password_reset_view.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    late String text;
    var w = MediaQuery.of(context).size.width; 

    return Scaffold(
      appBar: AppBar(
        title: Consumer<AppUsers>(
          builder: (_, user, __) {
            if(!user.forgotPassword && user.isRegistered){
              text = 'User Login';
            } else if(!user.forgotPassword && !user.isRegistered){
              text = 'User Registration';
            } else {
              text = 'User Password Reset';
            }
            return SliderAnimationView(child: Text(text));
          }
        ), 
        //centerTitle: true,
        backgroundColor: blackColor, 
        elevation: 10, 
        foregroundColor: whiteColor
      ),
      backgroundColor: backGroundColor,
      
      body: Center(
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
                  color: blackColor
                )
              ]
            ),
            child: Column(
              children: [                          
                Consumer<AppUsers>(
                  builder: (_, user,__) => TextItem(
                    text: user.isRegistered ? 'Sign In': 'Sign Up', 
                    fontSize: fontSize2, 
                    fontWeight: fontWeight2, 
                    color: deepGreenColor
                  ),
                ),
                const Gap(10),
                const Divider(height: 1, color: greenColor), 
                const Gap(10),
                
                Consumer<AppUsers>(
                  builder: (_, user,__) => user.isRegistered
                  ? const SizedBox.shrink()
                  : LoginAndSignUpTextFields(
                    textItem: 'Username',
                    color: whiteColor,
                    enabled: true,
                    controller: user.usernameController,
                  )
                ),
                
                Consumer<AppUsers>(
                  builder: (_, user,__) => LoginAndSignUpTextFields(
                    textItem: 'Email',
                    color: whiteColor,
                    enabled: user.forgotPassword ? false : true,
                    controller: user.emailController,
                  ),
                ),
                
                Consumer<AppUsers>(
                  builder: (_, user,__) => LoginAndSignUpTextFields(
                    textItem: 'Password',
                    showSuffixIcon: true,
                    color: whiteColor,
                    enabled: user.forgotPassword ? false : true,
                    controller: user.passwordController,
                  ),
                ),                  
                
                Consumer<AppUsers>(
                  builder: (_, user,__) => user.isRegistered ?
                  const SizedBox.shrink()
                  : LoginAndSignUpTextFields(
                    textItem: 'Confirm Password',
                    showSuffixIcon: true,
                    color: whiteColor,
                    enabled: user.forgotPassword ? false : true,
                    controller: user.confirmPassController,
                  ),
                ),
                
      
                Consumer<AppUsers>(
                  builder: (_, user, __) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      user.isRegistered ? GestureDetector(
                        onTap: (){
                          user.emailController.clear(); 
                          user.passwordController.clear(); 
                          user.callToAction(() => user.forgotPassword = true);                            
                          //This part brings up the snackbar that 
                          //contains the password reset view.
      
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20), 
                                  topRight: Radius.circular(20),
                                )
                              ),
                              backgroundColor: darkWhiteColor, 
                              duration: const Duration(days: 1),
                              content: Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                                decoration: BoxDecoration(
                                  color: darkWhiteColor, 
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 10, 
                                      spreadRadius:1, 
                                      color: Colors.black54
                                    )
                                  ]                      
                                ),
                                child: const PasswordResetView()
                              )
                            )
                          );
                        },
                        child: const TextItem(
                          text: 'Forgot Password?', 
                          fontSize: fontSize1, 
                          fontWeight: fontWeight2,
                          color: blackColor
                        ),
                      ) : const SizedBox.shrink(),
      
                      GestureDetector(
                        onTap: (){
                          user.emailController.clear(); 
                          user.passwordController.clear(); 
                          user.usernameController.clear(); 
                          user.confirmPassController.clear();
                          user.callToAction(() => user.isRegistered = !user.isRegistered);
                        },
                        child: TextItem(
                          text: user.isRegistered ? 'Not Registered?' : 'Already Registered?',
                          fontSize: fontSize1, 
                          fontWeight: fontWeight2,
                          color: blackColor
                        ),
                      ),
                    ] 
                  ),
                ),
                
                const Gap(20), 
                const Divider(height:1, color: greenColor), 
                const Gap(20),
      
                Consumer<AppUsers>(
                  builder: (_, user, __) => ElevatedButton(
                    onPressed: () async{            
                      //user Login
                      bool loginFieldsNotEmpty = [
                        user.emailController, 
                        user.passwordController
                      ].every((controller) => controller.text.isNotEmpty);
      
                      if(user.isRegistered){
                        if(loginFieldsNotEmpty){
                          ProgressIndicatorDialog().alert(context, 'Please Wait...');
                          await FirebaseAuthLogin().firebaseLogin(
                            user.emailController.text.trim(), 
                            user.passwordController.text.trim(),
                            (text, color, icon) async{
                              Navigator.of(context).pop();
                              await MaterialBannerAlert1(context)
                                .materialBannerAlert1(text, color, icon);
                            } 
                          ).then((result) async{
                            if(result != 'no' && result != 'email not verified'){
                              user.loggedInUser = result;
                              user.emailController.clear(); 
                              user.passwordController.clear();
                              Navigator.of(context)
                                .pushNamedAndRemoveUntil(homePageRoute, (route) => false);
                            } 
                            else{
                              await FirebaseEmailVerification().verifyEmail(
                                (text, color, icon) async{
                                  Navigator.of(context).pop();
                                  await MaterialBannerAlert1(context)
                                    .materialBannerAlert1(text, color, icon);
                                }
                              );
                            }
                          },);                                  
                        }
                        //Either email or password field or both is empty
                        else{
                          MaterialBannerAlert1(context).materialBannerAlert1(
                            'Fields Cannot be Empty!!!', 
                            redColor, 
                            Icons.warning_rounded
                          );
                        }                               
                      }
                              
                      //User Registration
                      else {
                        bool registrationFieldsNotEmpty = [
                          user.emailController, 
                          user.passwordController,
                          user.confirmPassController, 
                          user.usernameController
                        ].every((controller) => controller.text.isNotEmpty);
      
                        if(registrationFieldsNotEmpty){
                          ProgressIndicatorDialog().alert(context, 'Please Wait...');
                          if(user.passwordController.text == user.confirmPassController.text){
                            await FirebaseAuthRegister().firebaseRegister(
                              user.usernameController.text.trim(),
                              user.emailController.text.trim(), 
                              user.passwordController.text.trim(),
                              (text, color, icon) async {
                                Navigator.of(context).pop();
                                await MaterialBannerAlert1(context)
                                  .materialBannerAlert1(text, color, icon);
                              } 
                            ).then((registrationResult) async {
                              registrationResult == 'yes'
                              ? await FirebaseEmailVerification().verifyEmail(
                                (text, color, icon) async{                                      
                                  await MaterialBannerAlert1(context)
                                    .materialBannerAlert1(text, color, icon);
                                }
                              )
                              : {
                                //Will still handle a case whereby the regisitration did not go through
                              };
                            });
                            user.emailController.clear(); 
                            user.passwordController.clear(); 
                            user.usernameController.clear();
                            user.confirmPassController.clear();
                            user.callToAction(() => user.isRegistered = true);
                          } 
                          //Password and confirmPassword fields do not match.
                          else {
                            Navigator.of(context).pop();
                            MaterialBannerAlert1(context).materialBannerAlert1(
                              'Password Confirmation Error!!!', 
                              redColor, 
                              Icons.warning_rounded
                            );
                          }
                        }
                        //Any or all of the registration fields is/are empty
                        else{
                          MaterialBannerAlert1(context).materialBannerAlert1(
                            'Field(s) Cannot be Empty!!!',
                            Colors.red, 
                            Icons.warning_rounded
                          );
                        }
                      }
                    },
                              
                    style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(w, 30)),
                      side: const MaterialStatePropertyAll(
                        BorderSide(width: 1, strokeAlign: 3, color: greenColor)
                      )
                    ),
                    child: TextItem(
                      text: user.isRegistered ? 'Login': 'Register', 
                      fontSize: fontSize1, 
                      fontWeight: fontWeight2,
                      color: greenColor
                    ),
                  ),
                ),
              ],
            )
          )
        )
      )
    );
  }
}