import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/extensions.dart';

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title, 
  required String content,
  required Map<String, T?> options
}) => showDialog<T>(
  context: context,
  builder: (_) => AlertDialog(
    title: Text(title).decorate(
      whiteColor, 
      fontSize4, 
      fontWeight2
    ),
    content: TextItem(
      text: content,
      color: whiteColor,
      fontSize: fontSize2, 
      fontWeight: fontWeight3
    ),
    actions: options.keys.map((optionKey){
      final optionValue = options[optionKey];
      return TextButton(
        onPressed: () => optionValue == null ?
          Navigator.pop(context) 
          : Navigator.of(context).pop(optionValue),
        child: Text(optionKey).decoratewithGoogleFont(
          customGreenColor, 
          fontSize2, 
          fontWeight1
        ),        
      );
    }).toList(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20)
    ),
    scrollable: true,
    backgroundColor: deepBackGroundColor  
  )
);