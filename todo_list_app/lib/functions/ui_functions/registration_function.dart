import 'package:flutter/material.dart';
import 'package:todo_list_app/backend_auth/auth_result.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/strings.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';


Future<void> registerNewUser(dynamic user, BuildContext context) async {
  bool registrationFieldsNotEmpty = [
    user.emailController, 
    user.passwordController,
    user.confirmPassController, 
    user.usernameController
  ].every((controller) => controller.text.isNotEmpty);

  if(registrationFieldsNotEmpty){
    final backend = FirebaseBackend();
    final loadingScreen = LoadingScreen();
    
    loadingScreen.showOverlay(context, registering);

    if(user.passwordController.text.trim() == user.confirmPassController.text.trim()){
      await backend.registerUser(
        user.usernameController.text.trim(), 
        user.emailController.text.trim(), 
        user.passwordController.text.trim()
      )
      .then((registrationResult) async {
        loadingScreen.hideOverlay();
        await showNotification(
          context, 
          registrationResult.runtimeType == SuccessfulAuthentication ?
            '${registrationResult.content}\n $checkYourEmail' :
            registrationResult.content,
          registrationResult.runtimeType == SuccessfulAuthentication ?
            Icons.check_rounded : Icons.error_rounded, 
          registrationResult.runtimeType == SuccessfulAuthentication ?
            greenColor : redColor
        ).then((_){
          if(registrationResult.runtimeType == SuccessfulAuthentication){
            user.emailController.clear(); 
            user.passwordController.clear(); 
            user.usernameController.clear();
            user.confirmPassController.clear();
            user.callToAction(() => user.isRegistered = true);
          }
        });
      });
    } 
    //Password and confirmPassword fields do not match.
    else {
      loadingScreen.hideOverlay();
      await showNotification(
        context, 
        unmatchedPasswords,
        Icons.warning_rounded,
        redColor,
      );
    }
  }
  //Any or all of the registration fields is/are empty
  else{
    await showNotification(
      context, 
      emptyFields, 
      Icons.warning_rounded, 
      redColor,
    );
  }
}