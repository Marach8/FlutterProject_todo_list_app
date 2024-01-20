import 'package:flutter/material.dart';


class ElevatedButtonWidget extends StatelessWidget{
  final void Function()? onPressed;
  final Widget child;
  final Color backgroundColor, borderColor;

  const ElevatedButtonWidget({
    super.key, 
    required this.onPressed, 
    required this.child,
    required this.backgroundColor,
    required this.borderColor
  });
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(backgroundColor),
        fixedSize: MaterialStatePropertyAll(Size(screenWidth, 30)),
        side: MaterialStatePropertyAll(
          BorderSide(
            width: 1, 
            strokeAlign: 3, 
            color: borderColor
          )
        )
      ),
      child: child,
    );
  }
}