import 'package:flutter/material.dart';

class SliderAnimationView extends StatefulWidget {
  final Widget child;
  final num translationDistance;
  final TextDirection textDirection;
  final Alignment? alignment;
  final double endOffset;
  final int? duration;

  const SliderAnimationView({
    this.alignment,
    this.duration,
    required this.textDirection,
    required this.endOffset,
    required this.translationDistance, 
    required this.child, 
    super.key
  });

  @override
  State<SliderAnimationView> createState() => _SliderAnimationState();
}

class _SliderAnimationState extends State<SliderAnimationView> 
with SingleTickerProviderStateMixin{
  late AnimationController sliderController;
  late Animation<Offset> sliderAnimation;

  @override 
  void initState(){
    super.initState();
    sliderController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration ?? 5)
    )..repeat();

    sliderAnimation = Tween<Offset> (
      begin: const Offset(0, 0), 
      end: Offset(widget.endOffset, 0)
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
 
    return Transform(
      alignment: widget.alignment,
      transform: Matrix4.identity()
        ..translate(widget.translationDistance),
      child: SlideTransition(
        position: sliderAnimation,
        textDirection: widget.textDirection,
        child: widget.child
      ),
    );
  }
}