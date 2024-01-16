import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/textfield_widget.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Column(
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
                child: Consumer<AppUsers>(
                  builder: (_, user, child) => Center(                    
                    child: IconButton(
                      onPressed: () {
                        user.forgotPasswordController.clear();
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        user.callToAction(() => user.forgotPassword = false);
                      }, 
                      icon: const Icon(
                        Icons.arrow_downward_rounded, 
                        color: blackColor
                      )
                    ),
                  ),
                ),
              ),
            )
          ]
        ),
        const Gap(20),
        const Divider(height: 1), 
        const Gap(20),

        Consumer<AppUsers>(
          builder: (_, user, __) => LoginAndSignUpTextFields(
            color: whiteColor,
            enabled: user.forgotPassword ? false : true,                        
            controller: user.passwordController,
          ),
        ), 
        const Gap(20),
        const Divider(height: 1), 
        const Gap(20),
        Consumer<AppUsers>(
          builder: (_, user, __) => ElevatedButton(
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
          ) 
        ),
      ],
    );
  }
}