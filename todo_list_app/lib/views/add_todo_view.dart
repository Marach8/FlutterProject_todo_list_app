import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/buttons/elevated_button.dart';
import 'package:todo_list_app/custom_widgets/divider.dart';
import 'package:todo_list_app/custom_widgets/generic_dialog.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';
import 'package:todo_list_app/custom_widgets/textfield_widget.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/extensions.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class AddUpdate extends StatelessWidget{
  const AddUpdate({super.key});

  @override 
  Widget build(BuildContext context) {   
    
    return Consumer<AppUsers>(
      builder: (_, user, __) => Scaffold(
        appBar: AppBar(
          centerTitle: true, 
          title: Text(
            user.isInUpdateMode
            ? 'Update you todo details'
            : 'Add your todo details here'
          )
            .decoratewithGoogleFont(
              whiteColor,
              fontSize3, 
              fontWeight1
            )
        ),
        backgroundColor: blackColor,
        
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AddTodoTextFields(
                  title: 'Title of Todo',
                  controller: user.todoTitleController,
                  onChanged: (newTitle){
                    if(user.isInUpdateMode){
                      if (newTitle != user.initialTitle){
                        user.wasteBin.add(
                          [
                            user.initialTitle, 
                            user.initialDate,
                            user.initialTodo
                          ]
                        );                        
                        for(List item in user.wasteBin){
                          FirestoreInteraction().deleteTodo(
                            user.firebaseCurrentUser!.uid, 
                            item[0]
                          );
                        }
                      }
                    }                  
                  }
                ),
                const Gap(5),
                const DividerWidget(),
                const Gap(5),
                AddTodoTextFields(
                  title: 'Due Date and/or Time',
                  controller: user.todoDateTimeController,
                ),
                const Gap(5),
                const DividerWidget(),
                const Gap(5),
                AddTodoTextFields(
                  title: 'Content of Todo',
                  controller: user.todoContentController,
                  ),
                    
                const Gap(5),
                const DividerWidget(),
                const Gap(5),
            
                ElevatedButtonWidget(
                  onPressed: () async{
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
                      SnackBarAlert(context: context)
                        .snackBarAlert('Oops!!! Fields cannot be empty!');                      
                    }
                  },
                  backgroundColor: backGroundColor,
                  borderColor: deepGreenColor,
                  child: TextItem(
                    color: greenColor,
                    fontSize: fontSize2,
                    fontWeight: fontWeight1,
                    text: user.isInUpdateMode ? 'Update Todo' : 'Save Todo'
                  )
                ),
              ]
            ),
          ),
        )
      ),
    );
  }
}