import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';

Future<void> loginToApp(dynamic user, BuildContext context) async {
  bool loginFieldsNotEmpty = [
    user.emailController, 
    user.passwordController
  ].every((controller) => controller.text.isNotEmpty);
  final loadingScreen = LoadingScreen();
 
  if(loginFieldsNotEmpty){
    loadingScreen.showOverlay(context, 'Logging in...');
    await FirebaseAuthLogin().firebaseLogin(
      user.emailController.text.trim(), 
      user.passwordController.text.trim(),
      (text, color, icon) async{
        loadingScreen.hideOverlay();
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
            loadingScreen.hideOverlay();
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