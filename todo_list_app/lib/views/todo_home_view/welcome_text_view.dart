import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';


class WelcomeTextView extends StatelessWidget {
  final dynamic user;
  const WelcomeTextView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return    
     Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Hello ${user.loggedInUser}, Welcome to your Todo Manager. You currently have ',
          ).decorate(
            whiteColor, 
            fontSize2, 
            fontWeight3
          ),
          TextSpan(text: '${user.dataBase.length}')
            .decorate(
              user.dataBase.isEmpty ? redColor : greenColor,
              fontSize2, 
              fontWeight1
            ),
          TextSpan(text: user.dataBase.length == 1? ' Todo.' : ' Todos.',)
            .decorate(
              whiteColor, 
              fontSize2, 
              fontWeight3
            )
        ]
      )
    );
  }
}