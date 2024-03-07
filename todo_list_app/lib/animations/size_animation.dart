import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/strings.dart';
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
    )..repeat(reverse: true);

    sizeAnimation = Tween<double> (
      begin: 0.0, end: 5.0
    ).animate(
      CurvedAnimation(
        parent: sizeController,
        curve: Curves.linear
      )
    );

    sizeAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        sizeController.reverse()
          .then((_) => sizeController.forward());
      }
    });
  }

  @override 
  void dispose(){
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sizeController.forward();
    return SizeTransition(
      sizeFactor: sizeAnimation,
      child: ScaleTransition(
        scale: sizeAnimation,
        child: Center(
          child: const Text(noStringToDisplay)
            .decoratewithGoogleFont(
              whiteColor, 
              fontSize1, 
              fontWeight3
            ),
        ),
      )
    );
  }
}