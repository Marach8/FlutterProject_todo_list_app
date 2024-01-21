import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/buttons/crud_button.dart';

class CrudButtonsView extends StatelessWidget {
  final dynamic user;
  
  const CrudButtonsView({
    required this.user,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    
    return Container(
      width: screenWidth,
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),                  
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            customGreenColor,
            backGroundColor,
            blueColor
          ],
          tileMode: TileMode.mirror
        ),
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          CrudButtonModel(
            icon: Icons.add, 
            text: 'Add',
            function: () => Navigator.of(context)
              .pushNamed(addTodoPageRoute)
          ),
      
          CrudButtonModel(
            icon: Icons.view_array, 
            text: 'View', 
            function: () async{
              if (user.dataBase.isNotEmpty) {
                await showNotification(
                  context, 
                  'To view an item in detail, tap on the item.', 
                  Icons.view_array_rounded, 
                  blueColor,
                  5
                ).then((_) => Navigator.of(context)
                  .pushNamed(viewPageRoute));

              } else {
                await noTodoNotify(context);
              }
            }
          ),
      
          CrudButtonModel(
            icon: Icons.delete,
            text: 'Delete',
            function: ()async{
              if (user.dataBase.isNotEmpty) {
                await showNotification(
                  context, 
                  'To delete an item, swipe horizontally', 
                  Icons.delete_rounded, 
                  blueColor,
                  5
                ).then((_) => Navigator.of(context)
                  .pushNamed(viewPageRoute));
              } else {
                await noTodoNotify(context);
              }
            }
          ),
      
          CrudButtonModel(
            icon: Icons.update_rounded, 
            text: 'Update', 
            function: () async{
              if (user.dataBase.isNotEmpty) {
                await showNotification(
                  context, 
                  'Longpress on an item to go to update mode', 
                  Icons.update_rounded, 
                  blueColor,
                  5
                ).then((_) => Navigator.of(context)
                  .pushNamed(viewPageRoute));
              } else {
                await noTodoNotify(context);
              }
            }
          ),                    
        ]
      ),
    );
  }
}


Future<void> noTodoNotify(BuildContext context) 
async => await showNotification(
  context, 
  'Oops! You currently have no Todos. Add Todos first!', 
  Icons.warning_rounded, 
  redColor,
  5
);