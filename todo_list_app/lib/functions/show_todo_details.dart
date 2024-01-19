import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/rich_text.dart';

dynamic showFullTodoDetails(
  BuildContext context,
  String title, 
  String dateTime,
  String content
) => ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(                                                
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(20), 
        topLeft: Radius.circular(20)
      )
    ),
    backgroundColor: Colors.blueGrey.shade900,
    content: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TodoRichText(
          heading: 'TITLE OF TODO: ',
          content: title
        ),
        const Gap(10),
        TodoRichText(
          heading: 'DATE/TIME OF TODO: '
          , content: dateTime
        ),
        const Gap(10),
        TodoRichText(
          heading: 'CONTENT OF TODO: '
          , content: content
        ),
        const Gap(10),
      ]
    ),
    duration: const Duration(seconds: 10),
    action: SnackBarAction(
      onPressed: () => ScaffoldMessenger.
        of(context).hideCurrentSnackBar(),
      label: 'Back', textColor: blueColor,
    )
  )
);