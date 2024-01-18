import 'package:flutter/material.dart';
import 'package:todo_list_app/custom_widgets/container_with_text.dart';

class ContainerWithTextView extends StatelessWidget {
  final dynamic user;
  const ContainerWithTextView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: screenWidth/4,
      width: screenWidth,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) => ContainerWithText(user: user),
        scrollDirection: Axis.horizontal,
      )
    );
  }
}