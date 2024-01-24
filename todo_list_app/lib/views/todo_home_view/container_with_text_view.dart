import 'package:flutter/material.dart';
import 'package:todo_list_app/custom_widgets/container_with_text.dart';
import 'package:todo_list_app/functions/ui_functions/show_todo_details.dart';

class ContainerWithTextView extends StatelessWidget {
  final dynamic user;
  const ContainerWithTextView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: screenWidth/4,
      width: screenWidth,
      child: ListView.builder(
        itemCount: user.dataBase!.length,
        itemBuilder: (_, index) {
          final mapOfTodoDetails = user.dataBase!.elementAt(index);
          final title = mapOfTodoDetails['title'];
          final date = mapOfTodoDetails['due-datetime'] ;
          final content = mapOfTodoDetails['content'];
          final datetimeOfCreation = mapOfTodoDetails['datetime-of-creation'];
          return GestureDetector(
            onTap: () => showFullTodoDetails(
              context, 
              title, 
              date,
              content,
              datetimeOfCreation
            ),
            child: ContainerWithText(
              title: title,
              content: content,
              index: index + 1
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      )
    );
  }
}