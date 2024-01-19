import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';

class ContainerWithText extends StatelessWidget {
  final String title, content;
  const ContainerWithText({
    required this.title, 
    required this.content, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final screenwidth = MediaQuery.sizeOf(context).width;

    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: screenwidth/6,
        width: screenwidth/3,
        decoration: BoxDecoration(
          color: backGroundColor,
          border: Border.all(
            color: greenColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Container(
          decoration: BoxDecoration(
            color: backGroundColor,
            border: Border.all(
              color: blueColor,
              width: 0.3,
            ),
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(title).decorate(
                    whiteColor, 
                    fontSize1,
                    fontWeight3
                  ),
                  Text(content).decorate(
                    darkWhiteColor, 
                    fontSize1,
                    fontWeight3
                  ),
                ],
              ),
            )
          )
        ),
      ),
    );
  }
}