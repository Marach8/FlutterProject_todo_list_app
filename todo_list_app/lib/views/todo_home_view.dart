import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';
import 'package:todo_list_app/custom_widgets/button_widget.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class TodoHome extends StatefulWidget{
  const TodoHome({super.key});

  @override 
  State<TodoHome> createState() => _Td();
}

class _Td extends State<TodoHome>{

  @override 
  Widget build(BuildContext context){
    
    return Consumer<AppUsers>(
      builder: ((context, user, child)
        => Scaffold(
          appBar: AppBar( 
            actions: [
              PopupMenuButton(
                color: Colors.blueGrey.shade100,        
                onSelected: (value) async {                  
                  if(value == 'logout'){
                    ProgressIndicatorDialog().alert(context, 'Logging Out...');
                    if(user.dataBase.isNotEmpty){                      
                      for(List item in user.dataBase){
                        await FirestoreInteraction().createTodo(
                          user.firebaseCurrentUser!.uid, item[0], {'title': item[0], 'datetime': item[1], 'content': item[2]}
                        );                        
                      }
                      user.dataBase.clear();
                    }
                    if(user.wasteBin.isNotEmpty){
                      for(List item in user.wasteBin){
                        await FirestoreInteraction().deleteTodo(user.firebaseCurrentUser!.uid, item[0]);
                      }
                      user.wasteBin.clear();                      
                    }
                    await FirebaseAuthLogout().firebaseLogout(
                      (text, color, icon) async {
                        Navigator.of(context).pop();
                        await MaterialBannerAlert1(context).materialBannerAlert1(text, color, icon);
                      }
                    ).then((value) {
                        user.done = true;
                        Navigator.of(context).pushNamedAndRemoveUntil(loginPageRoute, (route) => false);
                      }                     
                    );                    
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value:'logout', height: 20, child: Text('Logout', style:TextStyle(color: Colors.black)),),
                ]
              ),
            ],
            centerTitle: true, title: const Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              children:[Icon(Icons.edit), SizedBox(width:10), Text('My Todo')]
            ),
            backgroundColor: const Color.fromARGB(255, 19, 19, 19), foregroundColor: Colors.blueGrey.shade300,          
          ),
          
          body: FutureBuilder<List<dynamic>>(
            future: FirebaseGetUserDetails().getCurrentUserDetails(),
            builder: (context, snapshot)  {
              if(snapshot.connectionState == ConnectionState.waiting){return const Center(child: CircularProgressIndicator());} 
              else if(snapshot.hasError) {return const Text('An error occured !!!');}
              else{
                if(snapshot.data == null){} else{
                    user.loggedInUser = snapshot.data![0]['username'];
                    user.firebaseCurrentUser = snapshot.data![2];
                    for(var items in snapshot.data![1].docs){                  
                    List<String> newList = [items['title'], items['datetime'], items['content']];
                    if(!user.dataBase.contains(newList)){
                      if (user.done){user.dataBase.add(newList);}                    
                    }                     
                  }
                  user.done = false;
                }             
                
                return Center(
                  child: SingleChildScrollView(                    
                    child: Container(
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/hills-2836301_1280.jpg'),
                          fit: BoxFit.cover
                        )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20), padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(221, 30, 30, 30).withOpacity(0.3),
                              boxShadow: [BoxShadow(color: Colors.blueGrey.withOpacity(0.1), blurRadius: 10, spreadRadius: 1,)],
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hello ${user.loggedInUser}, Welcome To Your Todo Manager. You currently have ',
                                    style: TextStyle(
                                    fontFamily: 'monospace', fontSize: 40,
                                    fontWeight: FontWeight.bold, color: Colors.blueGrey.shade800
                                    )
                                  ),
                                  TextSpan(
                                    text: '${user.dataBase.length}',
                                    style: TextStyle(
                                    fontFamily: 'monospace', fontSize: 40,
                                    fontWeight: FontWeight.bold, color: Colors.blueGrey.shade200
                                    )
                                  ),
                                  TextSpan(
                                    text: user.dataBase.length == 1? ' Todo' : ' Todos',
                                    style: const TextStyle(
                                    fontFamily: 'monospace', fontSize: 40,
                                    fontWeight: FontWeight.bold, color: Colors.blueGrey
                                    )
                                  ),
                                ]
                              )
                            )
                          ),
                                      
                          const SizedBox(height: 20),
                                      
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(20),                  
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Colors.green, Colors.blueGrey, Colors.blue],
                                tileMode: TileMode.mirror
                              ),
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Wrap(
                                children: [
                                  HomeButtons().homeButton(Icons.add, 'Add', () => Navigator.of(context).pushNamed(addTodoPageRoute)),
                                  HomeButtons().homeButton(
                                    Icons.view_array, 'View', (){
                                      if (user.dataBase.isNotEmpty) {
                                        MaterialBannerAlert(context: context).materialBannerAlert(
                                          'To view an item in detail, tap on the item.', Icons.view_array_rounded
                                        );
                                        Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                                        Navigator.of(context).pushNamed('/view');
                                      } else {
                                        SnackBarAlert(context: context).snackBarAlert(
                                          'Oops!!! seems like you currently have no Todos. Add Todos first!'
                                        );
                                      }
                                    }
                                  ),
                                  HomeButtons().homeButton(
                                    Icons.delete, 'Delete', (){
                                      if (user.dataBase.isNotEmpty) {
                                        MaterialBannerAlert(context: context).materialBannerAlert(
                                          'To delete an item, swipe the item to the left or right.', Icons.delete
                                        );
                                        Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                                        Navigator.of(context).pushNamed(viewPageRoute);
                                      } else {
                                        SnackBarAlert(context: context).snackBarAlert(
                                          'Oops!!! seems like you currently have no Todos. Add Todos first!'
                                        );
                                      }
                                    }
                                  ),
                                  HomeButtons().homeButton(
                                    Icons.update_rounded, 'Update', (){
                                      if (user.dataBase.isNotEmpty) {
                                        MaterialBannerAlert(context: context).materialBannerAlert(
                                          'To update an item, longpress on it to enter update mode.', Icons.update_sharp
                                        );
                                        Future.delayed(const Duration(seconds:5), () =>ScaffoldMessenger.of(context).hideCurrentMaterialBanner());
                                        Navigator.of(context).pushNamed('/view');
                                      } else {
                                        SnackBarAlert(context: context)
                                        .snackBarAlert('Oops!!! seems like you currently have no Todos. Add Todos first!');
                                      }
                                    }
                                  ),                    
                                ]
                              ),
                            ),
                          ),
                        ]
                      ),
                    ),
                  ),
                );
              } 
            }                    
          )
        )
      )
    );
  }
}