import 'package:flutter/material.dart';
import 'package:todo_list_app/custom_widgets/container_with_text.dart';
import 'package:todo_list_app/functions/show_todo_details.dart';

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
        itemCount: user.dataBase.length,
        itemBuilder: (_, index) {
          final title = user.dataBase.elementAt(index)[0];
          final date = user.dataBase.elementAt(index)[1];
          final content = user.dataBase.elementAt(index)[2];
          return GestureDetector(
            onTap: () => showFullTodoDetails(
              context, 
              title, 
              date,
              content
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