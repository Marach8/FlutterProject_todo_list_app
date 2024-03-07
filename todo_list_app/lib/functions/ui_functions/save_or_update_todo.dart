import 'package:flutter/material.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/strings.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/generic_dialog.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';
import 'package:todo_list_app/functions/extensions.dart';


Future<void> saveOrUpdateTodo(
  dynamic user, 
  BuildContext context
) async{
  bool hasData = [
    user.todoTitleController, 
    user.todoDateTimeController, 
    user.todoContentController
  ].every((controller) => controller.text.isNotEmpty);
  if(hasData){
    final loadingScreen = LoadingScreen();
    final backend = FirebaseBackend();

    //Updating an existing Todo
    if(user.isInUpdateMode){
      loadingScreen.showOverlay(context, updating);

      final newTitle = user.todoTitleController.text.trim();
      final newDueDateTime = user.todoDateTimeController.text.trim();
      final newContent = user.todoContentController.text.trim();

      final initialTitle = user.todoToUpdate[titleString].trim();
      final initialDueDateTime = user.todoToUpdate[dueDateTime].trim();
      final initialContent = user.todoToUpdate[contentString].trim();

      final newMap = {
        'title': newTitle,
        'due-datetime': newDueDateTime,
        'content': newContent
      };
      final mapsAreEqual = newMap.checkMapEquality(user.todoToUpdate);
      mapsAreEqual 
      ? {
        loadingScreen.hideOverlay(),
        await showNotification(
          context, 
          noChangesToUpdate,
          Icons.info,
          customGreenColor
        )
        .then((_) {
          user.todoTitleController.clear();
          user.todoDateTimeController.clear();
          user.todoContentController.clear();
          user.callToAction(() => user.isInUpdateMode = false);
          Navigator.pop(context);
        })
      } 
      : await backend.updateTodo(
          initialTitle,
          initialDueDateTime,
          initialContent, 
          newTitle, 
          newDueDateTime, 
          newContent
        )
        .then((updateResult) async{
          final successfulUpdate = updateResult == 'Update Successful...';
          loadingScreen.hideOverlay();
            await showNotification(
              context, 
              updateResult, 
              successfulUpdate ?
                Icons.check : Icons.warning_rounded,
              successfulUpdate ?
                greenColor : redColor
            )
            .then((_){
              user.todoTitleController.clear();
              user.todoDateTimeController.clear();
              user.todoContentController.clear();
              user.callToAction(() => user.isInUpdateMode = false);
              Navigator.pop(context);
            });
        });
    }
    //Saving a new Todo
    else{
      loadingScreen.showOverlay(context, 'Saving...');
      backend.uploadTodo(
        user.todoTitleController.text.trim(),
        user.todoDateTimeController.text.trim(),
        user.todoContentController.text.trim()
      );
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
      emptyFields, 
      Icons.warning_rounded, 
      redColor,
    );                   
  }
}