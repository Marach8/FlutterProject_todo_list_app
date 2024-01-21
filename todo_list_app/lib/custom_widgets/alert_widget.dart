import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/functions/extensions.dart';

Future<void> showNotification(
  BuildContext context, 
  String text,
  IconData? icon,
  Color buttonColor,
  int duration
) async{
  final materialBanner = MaterialBanner(

    content: Text(
      text,
      maxLines: 2,
    ).decoratewithGoogleFont(
      whiteColor,
      fontSize2,
      fontWeight3
    ), 
    actions: [
      TextButton(
        onPressed:(){
          ScaffoldMessenger.of(context)
            .hideCurrentMaterialBanner();
        }, 
        child: const Text('Ok')
          .decoratewithGoogleFont(
            buttonColor, 
            fontSize3, 
            fontWeight4
          )
      )
    ],
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
  Future.delayed(const Duration(seconds: 5), () 
    => ScaffoldMessenger.of(context)
    .hideCurrentMaterialBanner()
  );
}