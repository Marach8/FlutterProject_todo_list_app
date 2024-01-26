import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';

class SizeAnimation extends StatefulWidget {

  const SizeAnimation({
    super.key,
  });

  @override
  State<SizeAnimation> createState() => _SizeAnimationState();
}

class _SizeAnimationState extends State<SizeAnimation> with 
SingleTickerProviderStateMixin{

  late AnimationController sizeController;
  late Animation<double> sizeAnimation;

  @override 
  void initState(){
    super.initState();
    sizeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      reverseDuration: const Duration(seconds: 2), 
    )..repeat();

    // sizeAnimation = CurvedAnimation(
    //   parent: sizeController, 
    //   curve: Curves.easeInOut
    // );
    sizeAnimation = Tween<double> (begin: 0.0, end: 10.0
    ).animate(sizeController);

    sizeAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        sizeController.reverse();
      }
    });
    sizeController.forward();
  }

  @override 
  void dispose(){
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(sizeAnimation.value);
    // print(sizeController.value);
    return SizeTransition(
      sizeFactor: sizeAnimation,
      child: ScaleTransition(
        scale: sizeAnimation,
        child: Center(
          child: Text(
            'Hello', 
            style: TextStyle(fontSize: 20),
          ),
        ),
      )
    );
  }
}