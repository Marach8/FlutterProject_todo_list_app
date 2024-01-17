import 'package:flutter/material.dart';

class WelcomeTextView extends StatelessWidget {
  final dynamic user;
  const WelcomeTextView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Hello ${user.loggedInUser}, Welcome To Your Todo Manager. You currently have ',
            style: TextStyle(
              fontFamily: 'monospace', 
              fontSize: 40,
              fontWeight: FontWeight.bold, 
              color: Colors.blueGrey.shade800
            )
          ),
          TextSpan(
            text: '${user.dataBase.length}',
            style: TextStyle(
              fontFamily: 'monospace', 
              fontSize: 40,
              fontWeight: FontWeight.bold, 
              color: Colors.blueGrey.shade200
            )
          ),
          TextSpan(
            text: user.dataBase.length == 1? ' Todo' : ' Todos',
            style: const TextStyle(
              fontFamily: 'monospace', 
              fontSize: 40,
              fontWeight: FontWeight.bold, 
              color: Colors.blueGrey
            )
          ),
        ]
      )
    );
                          
  }
}