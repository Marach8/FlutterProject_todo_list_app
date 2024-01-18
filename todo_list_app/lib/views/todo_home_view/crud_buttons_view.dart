import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/button_widget.dart';

class CrudButtonsView extends StatelessWidget {
  final dynamic user;
  const CrudButtonsView({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    
    return Container(
      width: screenWidth,
      margin: const EdgeInsets.all(10),                  
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Colors.green, 
            Colors.blueGrey,
            Colors.blue
          ],
          tileMode: TileMode.mirror
        ),
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(20)
      ),
      child: Center(
        child: Wrap(
          children: [
            CrudButtonModel(
              icon: Icons.add, 
              text: 'Add',
              function: () => Navigator.of(context).pushNamed(addTodoPageRoute)
            ),

            CrudButtonModel(
              icon: Icons.view_array, 
              text: 'View', 
              function: (){
                if (user.dataBase.isNotEmpty) {
                  MaterialBannerAlert(context: context).materialBannerAlert(
                    'To view an item in detail, tap on the item.', 
                    Icons.view_array_rounded
                  );
                  Future.delayed(
                    const Duration(seconds:5), 
                    () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                  );
                  Navigator.of(context).pushNamed('/view');
                } else {
                  SnackBarAlert(context: context).snackBarAlert(
                    'Oops!!! seems like you currently have no Todos. Add Todos first!'
                  );
                }
              }
            ),

            CrudButtonModel(
              icon: Icons.delete,
              text: 'Delete',
              function: (){
                if (user.dataBase.isNotEmpty) {
                  MaterialBannerAlert(context: context).materialBannerAlert(
                    'To delete an item, swipe the item to the left or right.', 
                    Icons.delete
                  );
                  Future.delayed(
                    const Duration(seconds:5), 
                    () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                  );
                  Navigator.of(context).pushNamed(viewPageRoute);
                } else {
                  SnackBarAlert(context: context).snackBarAlert(
                    'Oops!!! seems like you currently have no Todos. Add Todos first!'
                  );
                }
              }
            ),

            CrudButtonModel(
              icon: Icons.update_rounded, 
              text: 'Update', 
              function: (){
                if (user.dataBase.isNotEmpty) {
                  MaterialBannerAlert(context: context).materialBannerAlert(
                    'To update an item, longpress on it to enter update mode.', 
                    Icons.update_sharp
                  );
                  Future.delayed(
                    const Duration(seconds:5), 
                    () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner()
                  );
                  Navigator.of(context).pushNamed('/view');
                } else {
                  SnackBarAlert(context: context)
                  .snackBarAlert(
                    'Oops!!! seems like you currently have no Todos. Add Todos first!'
                  );
                }
              }
            ),                    
          ]
        ),
      ),
    );
  }
}