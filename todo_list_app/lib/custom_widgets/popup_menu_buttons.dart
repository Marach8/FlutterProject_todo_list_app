import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/generic_dialog.dart';
import 'package:todo_list_app/functions/extensions.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class PopUpMenu extends StatelessWidget {
  const PopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppUsers>(
      builder: (_, user, __) => PopupMenuButton(
        color: whiteColor,        
        onSelected: (value) async {                  
          if(value == 'logout'){
            await showGenericDialog(
              context: context,
              content: 'Are sure you want to logout?',
              title: 'Logout',
              options: {
                'Cancel': false,
                'Logout': true
              }
            ).then((shouldLogOut) async {
              if(shouldLogOut == true){
                ProgressIndicatorDialog().alert(context, 'Logging Out...');
                if(user.dataBase.isNotEmpty){                      
                  for(List item in user.dataBase){
                    await FirestoreInteraction().createTodo(
                      user.firebaseCurrentUser!.uid, 
                      item[0], 
                      {
                        'title': item[0], 
                        'datetime': item[1], 
                        'content': item[2]
                      }
                    );                        
                  }
                  user.dataBase.clear();
                }
                if(user.wasteBin.isNotEmpty){
                  for(List item in user.wasteBin){
                    await FirestoreInteraction()
                      .deleteTodo(user.firebaseCurrentUser!.uid, item[0]);
                  }
                  user.wasteBin.clear();                      
                }
                await FirebaseAuthLogout().firebaseLogout(
                  (text, color, icon) async {
                    Navigator.of(context).pop();
                    await MaterialBannerAlert1(context)
                      .materialBannerAlert1(text, color, icon);
                  }
                ).then((value) {
                    user.done = true;
                    Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginPageRoute, (route) => false);
                  }                     
                ); 
              }
            });                                       
          }
        },
      
        itemBuilder: (context) => [
          PopupMenuItem(
            value:'logout', 
            height: 20, 
            child: const Text('Logout')
              .decorate(blackColor, fontSize1, fontWeight1),
          ),
        ]
      ),
    );
  }
}