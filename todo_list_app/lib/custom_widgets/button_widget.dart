import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';

class CrudButtonModel extends StatelessWidget {
  final String text;
  final VoidCallback function;
  final IconData icon;

  const CrudButtonModel({
    required this.text,
    required this.function,
    required this.icon, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: const ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(
          whiteColor
        )
      ),
      onPressed: function, 
      icon: Icon(icon, color: Colors.blue,),
      label: Text(text).decoratewithGoogleFont(
        whiteColor, 
        fontSize2, 
        fontWeight3
      )
    );
  }
}