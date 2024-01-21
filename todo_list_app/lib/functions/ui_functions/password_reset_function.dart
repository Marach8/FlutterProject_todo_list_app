import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';

Future<void> resetUserPassword(dynamic user, BuildContext context) async{
  final loadingScreen = LoadingScreen();                                                                                                     
  if(user.forgotPasswordController.text.isNotEmpty){
    loadingScreen.showOverlay(context, 'Please Wait...');
    await FirebaseResetPassword().resetPassword(
      user.forgotPasswordController.text,
      (text, color, icon) async{
        loadingScreen.hideOverlay();
        await MaterialBannerAlert1(context).materialBannerAlert1(
          text, color, icon
        );
      }
      ).then((_) {
      user.forgotPasswordController.clear();
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      user.callToAction(() => user.forgotPassword = false);
    });
  } else{
    MaterialBannerAlert1(context).materialBannerAlert1(
      'Fields Cannot be Empty!!!',
      redColor,
      Icons.warning_rounded
    );
  }     
}