import 'package:flutter/material.dart';

class SliderAnimationView extends StatefulWidget {
  final Widget child;
  const SliderAnimationView({required this.child , super.key});

  @override
  State<SliderAnimationView> createState() => _SliderAnimationState();
}

class _SliderAnimationState extends State<SliderAnimationView> with SingleTickerProviderStateMixin{
  late AnimationController sliderController;
  late Animation<Offset> sliderAnimation;

  @override 
  void initState(){
    super.initState();
    sliderController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5)
    )..repeat();

    sliderAnimation = Tween<Offset> (
      begin: const Offset(0, 0), end: const Offset(2, 0)
    ).animate(sliderController);

    sliderAnimation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        sliderController..reset()..forward();
      }
    });
  }

  @override 
  void dispose(){
    sliderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    sliderController.forward();
    //final w = MediaQuery.of(context).size.width;
    return SlideTransition(
      position: sliderAnimation,
      textDirection: TextDirection.ltr,
      child: widget.child
    );
  }
}