import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';

Future<void> showNotification(
  BuildContext context, 
  String text,
  IconData? icon,
  Color buttonColor,
) async{
  final completer = Completer<void>();
  final materialBanner = MaterialBanner(
    content: Text(
      text,
      maxLines: 4,
    ).decoratewithGoogleFont(
      whiteColor,
      fontSize2,
      fontWeight1
    ), 
    actions: [
      TextButton(
        onPressed:(){
          ScaffoldMessenger.of(context)
            .hideCurrentMaterialBanner();
          completer.complete();
        }, 
        child: const Text('Ok')
          .decoratewithGoogleFont(
            buttonColor, 
            fontSize3, 
            fontWeight4
          )
      )
    ],
    dividerColor: deepGreenColor,
    backgroundColor: backGroundColor,
    padding: const EdgeInsets.all(10),
    leading: Icon(
      icon,
      size: 40, 
      color: buttonColor
    ), 
  );
  ScaffoldMessenger.of(context)
    .showMaterialBanner(materialBanner);
  
  await Future.any([
    completer.future,
    Future.delayed(
    const Duration(seconds: 5), () 
      => ScaffoldMessenger.of(context)
        .hideCurrentMaterialBanner()
    )
  ]);
}