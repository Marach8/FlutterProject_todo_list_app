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
      duration: const Duration(seconds: 10),
      reverseDuration: const Duration(seconds: 10), 
    )..repeat(reverse: true);

    sizeAnimation = Tween<double> (begin: 0.0, end: 50.0
    ).animate(sizeController);

    // sizeController.repeat(reverse: true);
    // sizeAnimation.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    //     sizeController.reverse();
    //   }
    // });
    sizeController.forward();
  }

  @override 
  void dispose(){
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(sizeAnimation.value);
    print(sizeController.value);
    return AnimatedSize(
      curve: Curves.easeInOut,
      duration: const Duration(seconds: 10),
      child: Container(
        height: 200, width: MediaQuery.of(context).size.width,
        child: Text('Hello', style: TextStyle(fontSize: sizeAnimation.value*1000),)
      )
    );
  }
}