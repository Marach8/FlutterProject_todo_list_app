import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';

class ContainerWithText extends StatelessWidget {
  final dynamic user;
  const ContainerWithText({required this.user, super.key});

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
          child: const Center(child: Text('Hello'))
        ),
      ),
    );
  }
}