import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Divider(color: deepGreenColor, thickness: 0.5,),
    );
  }
}