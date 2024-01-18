import 'package:flutter/material.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

@immutable 
class LoadingScreenController{
  final CloseLoadingScreen closeScreen;
  final UpdateLoadingScreen updateScreen;

  const LoadingScreenController({
    required this.closeScreen,
    required this.updateScreen
  });
}