import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';

class TodoRichText extends StatelessWidget {
  final String heading, content;

  const TodoRichText({
    required this.heading, 
    required this.content, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),                            
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade900,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5, 
            spreadRadius: 1, 
            color: Color.fromARGB(255, 170, 169, 249)
          )
        ]
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: heading)
              .decorate(
                whiteColor, 
                fontSize1, 
                fontWeight1
              ),
            TextSpan(text: content)
              .decorate(
                whiteColor, 
                fontSize1, 
                fontWeight1
              ),
          ]
        )
      )
    );
  }
}