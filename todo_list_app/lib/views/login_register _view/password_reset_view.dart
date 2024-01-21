import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/buttons/elevated_button.dart';
import 'package:todo_list_app/custom_widgets/textfield_widget.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/todo_provider.dart';
import 'package:todo_list_app/functions/ui_functions/password_reset_function.dart';

class PasswordResetView extends StatelessWidget {
  const PasswordResetView({super.key});

  @override
  Widget build(BuildContext context) => Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TextItem(
              text: 'Password Reset', 
              fontSize: fontSize4, 
              fontWeight: fontWeight1,
              color: blackColor
            ),
            Container(
              width:45,
              decoration: BoxDecoration(
                color: customGreenColor,
                shape: BoxShape.circle,                                                          
                border: Border.all(width:1)
              ),
              child: Consumer<AppUsers>(
                builder: (_, user, __) => Center(                    
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
            )
          ]
        ),
        const Gap(20),
        const Divider(height: 1), 
        const Gap(25),

        Consumer<AppUsers>(
          builder: (_, user, __) => LoginAndSignUpTextFields(
            hintText: 'Enter your email...',
            color: whiteColor,
            enabled: user.forgotPassword ? true: false,
            controller: user.forgotPasswordController,
          ),
        ), 
        const Gap(20),
        const Divider(height: 1), 
        const Gap(20),
        Consumer<AppUsers>(
          builder: (_, user, __) => ElevatedButtonWidget(
            onPressed: () async 
              => await resetUserPassword(user, context),
            backgroundColor: customGreenColor,
            borderColor: blackColor,
            child: const TextItem(
              text: 'Change Password', 
              fontSize: fontSize2, 
              fontWeight: fontWeight2,
              color: blackColor
            ),
          ) 
        ),
      ],
    );
}