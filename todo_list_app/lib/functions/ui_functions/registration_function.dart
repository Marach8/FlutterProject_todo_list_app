import 'package:flutter/material.dart';
import 'package:todo_list_app/backend_auth/auth_result.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';


Future<void> registerNewUser(dynamic user, BuildContext context) async {
  final backend = FirebaseBackend();
  final loadingScreen = LoadingScreen();
  bool registrationFieldsNotEmpty = [
    user.emailController, 
    user.passwordController,
    user.confirmPassController, 
    user.usernameController
  ].every((controller) => controller.text.isNotEmpty);

  if(registrationFieldsNotEmpty){
    loadingScreen.showOverlay(context, 'Registering...');

    if(user.passwordController.text == user.confirmPassController.text){
      await backend.registerUser(
        user.usernameController.text.trim(), 
        user.emailController.text.trim(), 
        user.passwordController.text.trim()
      )
      // await FirebaseAuthRegister().firebaseRegister(
      //   user.usernameController.text.trim(),
      //   user.emailController.text.trim(), 
      //   user.passwordController.text.trim(),
      //   (text, color, icon) async {
      //     loadingScreen.hideOverlay();
      //     await showNotification(
      //       context,
      //       text, 
      //       icon, 
      //       color,
      //     );
      //   } 
      // )
      .then((registrationResult) async {
        
        // registrationResult.runtimeType == AuthSuccess
        // ? await FirebaseEmailVerification().verifyEmail(
        //   (text, color, icon) async{                                      
        //     await showNotification(
        //       context, 
        //       text, 
        //       icon, 
        //       color,
        //     );
        //   }
        // )
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
      loadingScreen.hideOverlay();
      await showNotification(
        context, 
        'Passwords do not Match!',
        Icons.warning_rounded,
        redColor,
      );
    }
  }
  //Any or all of the registration fields is/are empty
  else{
    await showNotification(
      context, 
      'Field(s) Cannot be Empty!', 
      Icons.warning_rounded, 
      redColor,
    );
  }
}