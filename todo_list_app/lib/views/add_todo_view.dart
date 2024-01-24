import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/custom_widgets/buttons/elevated_button.dart';
import 'package:todo_list_app/custom_widgets/divider.dart';
import 'package:todo_list_app/custom_widgets/textfield_widget.dart';
import 'package:todo_list_app/custom_widgets/textitem_widget.dart';
import 'package:todo_list_app/functions/extensions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';
import 'package:todo_list_app/functions/ui_functions/save_or_update_todo.dart';

class AddUpdate extends StatelessWidget{
  const AddUpdate({super.key});

  @override 
  Widget build(BuildContext context) {   
    
    return Consumer<AppUsers>(
      builder: (_, user, __) => Scaffold(
        appBar: AppBar(
          backgroundColor: backGroundColor,
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
                  onPressed: () async => 
                    saveOrUpdateTodo(user, context),
                  backgroundColor: backGroundColor,
                  borderColor: deepGreenColor,
                  child: TextItem(
                    color: darkWhiteColor,
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