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
        color: deepBackGroundColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            blurRadius: 5, 
            spreadRadius: 1, 
            color: whiteColor
          )
        ]
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: heading)
              .decorate(
                darkWhiteColor, 
                fontSize2, 
                fontWeight1
              ),
            TextSpan(text: content)
              .decorate(
                whiteColor, 
                fontSize2, 
                fontWeight1
              ),
          ]
        )
      )
    );
  }
}