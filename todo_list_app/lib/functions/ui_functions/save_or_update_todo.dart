import 'package:flutter/material.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/generic_dialog.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';

Future<void> saveOrUpdateTodo(
  dynamic user, 
  BuildContext context
) async{
  final loadingScreen = LoadingScreen();
  bool hasData = [
    user.todoTitleController, 
    user.todoDateTimeController, 
    user.todoContentController
  ].every((controller) => controller.text.isNotEmpty);
  if(hasData){
    //Updating an existing Todo
    if(user.isInUpdateMode){
      loadingScreen.showOverlay(context, 'Updating...');
      user.addTodo(user.updateIndex); 
      if(user.dataBase.isNotEmpty){                      
        for(List item in user.dataBase){
          FirestoreInteraction().createTodo(
            user.firebaseCurrentUser!.uid, 
            item[0], 
            {
              'title': item[0], 
              'datetime': item[1], 
              'content': item[2]
            }
          );                        
        }                          
      }
      loadingScreen.hideOverlay();
      user.todoTitleController.clear();
      user.todoDateTimeController.clear();
      user.todoContentController.clear();
      user.callToAction(() => user.isInUpdateMode = false);
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/home', (route) => false
      );
    }
    //Saving a new Todo
    else{
      loadingScreen.showOverlay(context, 'Saving...');
      user.addTodo(user.dataBase.length);
      if(user.dataBase.isNotEmpty){                      
        for(List item in user.dataBase){
          FirestoreInteraction().createTodo(
            user.firebaseCurrentUser!.uid, 
            item[0], 
            {
              'title': item[0], 
              'datetime': item[1], 
              'content': item[2]
            }
          );                        
        }                          
      }
      loadingScreen.hideOverlay();
      user.todoTitleController.clear();
      user.todoDateTimeController.clear();
      user.todoContentController.clear();
      await showGenericDialog(
        context: context, 
        title: 'Save Todo', 
        content: 'Your todo has been saved sucessfully. Do you want to add another?',
        options: {
          'No': false,
          'Yes': true
        }
      ).then((addAnotherTodo) =>
        addAnotherTodo == false
          ? Navigator.pop(context) :{}
      );
    }                    
  } 
  else {
    await showNotification(
      context, 
      'Field(s) Cannot be Empty!', 
      Icons.warning_rounded, 
      redColor,
    );                   
  }
}