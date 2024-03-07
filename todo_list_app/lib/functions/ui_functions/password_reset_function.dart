import 'package:flutter/material.dart';
import 'package:todo_list_app/backend_auth/auth_result.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/strings.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';


Future<void> resetUserPassword(dynamic user, BuildContext context) async{
                                                                                                      
  if(user.forgotPasswordController.text.isNotEmpty){
    final backend = FirebaseBackend();
    final loadingScreen = LoadingScreen(); 
    loadingScreen.showOverlay(context, pleaseWait);

    await backend.resetUserPassword(
      user.forgotPasswordController.text
    )
    .then((passwordResetResult) async{
      await showNotification(
        context,
        passwordResetResult.content,
        passwordResetResult.runtimeType == SuccessfulAuthentication ?
          Icons.check_rounded : Icons.error_rounded, 
        passwordResetResult.runtimeType == SuccessfulAuthentication ?
          greenColor : redColor
      )
      .then((_){
        user.forgotPasswordController.clear();
        loadingScreen.hideOverlay();
        if(passwordResetResult.runtimeType == SuccessfulAuthentication){
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          user.callToAction(() => user.forgotPassword = false);
        }
      });
    });

  } else{
    await showNotification(
      context, 
      emptyFields, 
      Icons.warning_rounded, 
      redColor,
    );
  }     
}