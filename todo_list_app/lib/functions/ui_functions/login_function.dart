import 'package:flutter/material.dart';
import 'package:todo_list_app/backend_auth/auth_result.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/constants/strings.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';


Future<void> loginToApp(dynamic user, BuildContext context) async {  
  bool loginFieldsNotEmpty = [
    user.emailController, 
    user.passwordController
  ].every((controller) => controller.text.isNotEmpty);
  
  if(loginFieldsNotEmpty){
    final backend = FirebaseBackend();
    final loadingScreen = LoadingScreen();

    loadingScreen.showOverlay(context, 'Logging in...');
    await backend.loginUser(
      user.emailController.text.trim(), 
      user.passwordController.text.trim(), 
      user
    )
    .then((loginResult) async{
      loadingScreen.hideOverlay();
      await showNotification(
        context,
        loginResult.runtimeType == UserNotVerifiedAuthError ?
          '${loginResult.content}\n $checkYourEmail': 
          loginResult.content,
        loginResult.runtimeType == SuccessfulAuthentication ?
          Icons.check_rounded : Icons.error_rounded, 
        loginResult.runtimeType == SuccessfulAuthentication ?
          greenColor : redColor
      ).then((_) async{
        if(loginResult.runtimeType == UserNotVerifiedAuthError){
          await backend.verifyUserEmail();
        }
        else if(loginResult.runtimeType == SuccessfulAuthentication){
          user.emailController.clear();
          user.passwordController.clear();
          Navigator.of(context).pushNamedAndRemoveUntil(
            homePageRoute, (route) => false
          );
        }
      });
    });                           
  }
  //Either email or password field or both is empty
  else{
    await showNotification(
      context, 
      emptyFields, 
      Icons.warning_rounded, 
      redColor,
    );
  }                               
}