import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/functions/extensions.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';
import 'package:todo_list_app/functions/show_todo_details.dart';

class Views extends StatelessWidget{
  const Views ({super.key});

  @override
  Widget build(BuildContext context){
    return Consumer<AppUsers>(
      builder: (context, user, child) => Scaffold(
        backgroundColor: backGroundColor,
        appBar: AppBar(
          centerTitle: true, 
          title: const Text('Welcome to your views')
            .decoratewithGoogleFont(
              whiteColor,
              fontSize3,
              fontWeight2
            ),
          backgroundColor: deepBackGroundColor, 
          foregroundColor: whiteColor
        ),

        body: ListView.builder(
          itemCount: user.dataBase.length,
          itemBuilder: (context, index) {
            final title = user.dataBase.elementAt(index)[0];
            final date = user.dataBase.elementAt(index)[1]; 
            final content = user.dataBase.elementAt(index)[2];
            
            return Dismissible(                
              key: Key(title),
              onDismissed: (direction) async {
                if(direction == DismissDirection.endToStart 
                || direction == DismissDirection.startToEnd){
                  bool shouldDeleteFromFirestore = true;
                  user.delete(title, date, content, index);                    
                  await ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating, 
                      margin: const EdgeInsets.only(bottom:100),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10)
                        )
                      ),
                      content: const Text('Item deleted!')
                        .decoratewithGoogleFont(
                          blackColor,
                          fontSize3, 
                          fontWeight3
                        ),
                      action: SnackBarAction(
                        onPressed: () {
                          user.undo(title, date, content, index);
                          shouldDeleteFromFirestore = false;
                        }, 
                        label: 'Undo', textColor: blueColor, 
                      ),
                      duration: const Duration(seconds: 4), backgroundColor: Colors.white,
                    )
                  ).closed; 
                  shouldDeleteFromFirestore? 
                  FirestoreInteraction().deleteTodo(
                    user.firebaseCurrentUser!.uid, title
                  ): {};                 
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
                      child: Icon(Icons.delete_rounded, 
                      color: blackColor)
                    ),
                    Align(
                      alignment: Alignment.centerRight, 
                      child: Icon(Icons.delete_rounded, 
                      color: blackColor)
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
                  content
                ),
                onLongPress: (){
                  user.callToAction(() => user.isInUpdateMode = true);
                  user.updateTodo(title, date, content, index);
                  Navigator.of(context).pushNamed(addTodoPageRoute);
                },
                leading: const Icon(
                  Icons.create, 
                  size: 40, 
                  color: blueColor
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
        ) 
      )
    );
  }
}