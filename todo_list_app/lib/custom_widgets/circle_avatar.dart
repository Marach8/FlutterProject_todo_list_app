import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';

class CircleAvatarWidget extends StatelessWidget {
  final Widget child;

  const CircleAvatarWidget({
    super.key,
    required this.child
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 10,
      backgroundColor: blackColor,
      child: Center(child: child)
    );
  }
}