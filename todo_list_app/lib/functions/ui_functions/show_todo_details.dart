import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/rich_text.dart';
import 'package:todo_list_app/functions/extensions.dart';

dynamic showFullTodoDetails(
  BuildContext context,
  String title, 
  String dateTime,
  String content
){
  final overlay = Overlay.of(context);
  if(!overlay.mounted){
    return;
  }
  final overlayEntry = OverlayEntry(
    builder: (_) => Material(
      color: blackColor.withAlpha(50),
      child: const Center(
        child: SizedBox.shrink()
      )
    )
  );
  overlay.insert(overlayEntry);

  final snackBar = SnackBar(                                                
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20), 
        topLeft: Radius.circular(20)
      )
    ),
    backgroundColor: deepBackGroundColor,
    content: Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: const Text('Full Todo Details')
              .decoratewithGoogleFont(
                whiteColor,
                fontSize3, 
                fontWeight1
              ),
          ),
          TodoRichText(
            heading: 'TITLE OF TODO: ',
            content: title
          ),
          const Gap(10),
          TodoRichText(
            heading: 'DATE/TIME OF TODO: ',
            content: dateTime
          ),
          const Gap(10),
          TodoRichText(
            heading: 'CONTENT OF TODO: ',
            content: content
          ),
          const Gap(10),
        ]
      ),
    ),
    duration: const Duration(seconds: 10),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar)
    .closed.then((_) => overlayEntry.remove());
}