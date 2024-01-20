import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/buttons/elevated_button.dart';
import 'package:todo_list_app/custom_widgets/divider.dart';
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
      builder: (context, user, child)
      => Scaffold(
        appBar: AppBar(
          centerTitle: true, 
          title: const Text('Add your todo details here')
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
                            user.firebaseCurrentUser!.uid, item[0]
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
                    bool hasData = [
                      user.todoTitleController, 
                      user.todoDateTimeController, 
                      user.todoContentController
                    ].every((controller) => controller.text.isNotEmpty);
                    if(hasData){
                      if(user.isInUpdateMode){
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
                        user.isInUpdateMode = false;
                      } 
                      else{
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
                      }
                      await DialogBox(context: context).dialogBox(
                        user.todoTitleController, 
                        user.todoDateTimeController, 
                        user.todoContentController
                      );                      
                    } else {
                      SnackBarAlert(context: context)
                        .snackBarAlert('Oops!!! Fields cannot be empty!');                      
                    }
                  },
                  backgroundColor: backGroundColor,
                  borderColor: deepGreenColor,
                  child: const TextItem(
                    color: greenColor,
                    fontSize: fontSize2,
                    fontWeight: fontWeight1,
                    text: 'Save Todo'
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