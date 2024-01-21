import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';

Future<void> registerNewUser(dynamic user, BuildContext context) async {
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
      await FirebaseAuthRegister().firebaseRegister(
        user.usernameController.text.trim(),
        user.emailController.text.trim(), 
        user.passwordController.text.trim(),
        (text, color, icon) async {
          loadingScreen.hideOverlay();
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
      loadingScreen.hideOverlay();
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
      redColor, 
      Icons.warning_rounded
    );
  }
}