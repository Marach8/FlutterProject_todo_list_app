import 'package:flutter/material.dart';

class SizeAnimation extends StatefulWidget {
  final Widget child;

  const SizeAnimation({
    super.key,
    required this.child
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
      duration: const Duration(seconds: 10)
    )..repeat();

    sizeAnimation = Tween<double> (begin: 0.0, end: 100.0
    ).animate(sizeController);

    sizeAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        sizeController..reset()..forward();
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
    return SizeTransition(
      sizeFactor: sizeAnimation,
      axis: Axis.horizontal,
      child: widget.child,
    );
  }
}