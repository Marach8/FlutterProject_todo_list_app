import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/constants/strings.dart';
import 'package:todo_list_app/custom_widgets/popup_menu_buttons.dart';
import 'package:todo_list_app/functions/extensions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';
import 'package:todo_list_app/functions/ui_functions/show_todo_details.dart';

class Views extends StatelessWidget{
  const Views ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        centerTitle: true, 
        title: const Text(welcomeToYourViews)
          .decoratewithGoogleFont(
            whiteColor,
            fontSize3,
            fontWeight2
          ),
        actions: [PopUpMenuForTodosView(contextForLoadingScreen: context)],
        backgroundColor: deepBackGroundColor, 
        foregroundColor: whiteColor
      ),

      body: Consumer<AppUsers>(
        builder: (_, user, __) => ListView.builder(
          itemCount: user.dataBase.length,
          itemBuilder: (_, index) {
            final mapOfTodoDetails = user.dataBase.elementAt(index);
            final title = mapOfTodoDetails[titleString];
            final date = mapOfTodoDetails[dueDateTime] ;
            final content = mapOfTodoDetails[contentString];
            final datetimeOfCreation = mapOfTodoDetails[creationDateTime];
            
            return Dismissible(                
              key: UniqueKey(),
              onDismissed: (direction) async {
                bool shouldDeleteFromRemote = true;
                if(direction == DismissDirection.endToStart 
                || direction == DismissDirection.startToEnd){
                  user.deletefromLocal(index);                    
                  await ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating, 
                      margin: const EdgeInsets.only(bottom:100),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      content: const Text(itemDeleted)
                        .decoratewithGoogleFont(
                          blackColor,
                          fontSize3, 
                          fontWeight4
                        ),
                      action: SnackBarAction(
                        onPressed: () {
                          user.revertDelete(index);
                          shouldDeleteFromRemote = false;
                        },
                        label: 'Undo', 
                        textColor: blueColor, 
                      ),
                      duration: const Duration(seconds: 4), 
                      backgroundColor: whiteColor
                    )
                  ).closed
                  .then(
                    (_) => shouldDeleteFromRemote 
                    ? user.deleteFromRemote()
                    : {}                    
                  );              
                }
              },
              
              background: Container(
                padding: const EdgeInsets.only(left:10, right: 15),
                height: 30, 
                color: blueColor, 
                alignment: Alignment.centerLeft,
                child: const Wrap(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft, 
                      child: Icon(
                        Icons.delete_rounded, 
                        color: blackColor
                      )
                    ),
                    Align(
                      alignment: Alignment.centerRight, 
                      child: Icon(
                        Icons.delete_rounded, 
                        color: blackColor
                      )
                    ),
                  ]
                )
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                onTap: () => showFullTodoDetails(
                  context,
                  title, 
                  date, 
                  content,
                  datetimeOfCreation
                ),
                onLongPress: (){
                  user.todoToUpdate = mapOfTodoDetails;
                  user.populateTodoFields();
                  user.callToAction(() => user.isInUpdateMode = true);
                  Navigator.of(context).pushNamed(addTodoPageRoute);
                },
                leading: const Icon(
                  Icons.create, 
                  size: 40, 
                  color: customGreenColor
                ),
                trailing: Text(date).decoratewithGoogleFont(
                  darkWhiteColor, 
                  fontSize1, 
                  fontWeight3
                ),
                title: Text(title).decoratewithGoogleFont(
                  whiteColor,
                  fontSize3,
                  fontWeight4
                ),
                subtitle: Text(content).decoratewithGoogleFont(
                  darkWhiteColor,
                  fontSize2,
                  fontWeight3
                )
              )
            );
          }
        ),
      ) 
    );
  }
}