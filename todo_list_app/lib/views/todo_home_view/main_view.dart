import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/animations/slider_animations.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/strings.dart';
import 'package:todo_list_app/custom_widgets/divider.dart';
import 'package:todo_list_app/custom_widgets/popup_menu_buttons.dart';
import 'package:todo_list_app/functions/extensions.dart';
import 'package:todo_list_app/functions/firebase_functions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';
import 'package:todo_list_app/views/todo_home_view/container_with_text_view.dart';
import 'package:todo_list_app/views/todo_home_view/crud_buttons_view.dart';
import 'package:todo_list_app/views/todo_home_view/welcome_text_view.dart';

class TodoHome extends StatelessWidget{
  const TodoHome({super.key});

  @override 
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;

    return Consumer<AppUsers>(
      builder: ((_, user, __)
        => Scaffold(
          backgroundColor: blackColor,
          appBar: AppBar( 
            actions: [PopUpMenu(contextForLoadingScreen: context)],
            centerTitle: true, 
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center ,
              children:[
                Icon(
                  Icons.edit, 
                  color: customGreenColor, 
                  size: fontSize4,
                ), 
                Gap(10), 
                Text('My Todo')
              ]
            ),
            backgroundColor: blackColor, 
            foregroundColor: whiteColor,          
          ),
          
          body: FutureBuilder<List<dynamic>>(
            future: FirebaseGetUserDetails().getCurrentUserDetails(),
            builder: (_, snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(
                    color: customGreenColor,
                  )
                );
              } 
              else if(snapshot.hasError){
                return const Text('An error occured !!!')
                .decoratewithGoogleFont(
                  whiteColor, 
                  fontSize2, 
                  fontWeight3
                );
              }
              else{
                if(snapshot.data == null){} 
                else{
                    user.loggedInUser = snapshot.data![0]['username'];
                    user.firebaseCurrentUser = snapshot.data![2];
                    for(var items in snapshot.data![1].docs){                  
                    List<String> newList = [
                      items['title'], 
                      items['datetime'], 
                      items['content']
                    ];
                    if(!user.dataBase.contains(newList)){
                      if (user.done){
                        user.dataBase.add(newList);
                      }                    
                    }                     
                  }
                  user.done = false;
                }             
                
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [                      
                        SizedBox(                       
                          height: 35,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                child: SliderAnimationView(
                                  duration: 20,
                                  endOffset: 3,
                                  textDirection: TextDirection.rtl,
                                  translationDistance: screenWidth,                            
                                  child: WelcomeTextView(user: user)
                                ),
                              ),
                            ]
                          ),
                        ),
                        const DividerWidget(),
                        Lottie.asset(
                          lottiePath,
                          fit: BoxFit.cover
                        ),
                        const DividerWidget(),
                        // ContainerWithTextView(user: user),
                        const DividerWidget(),
                        CrudButtonsView(user: user)
                      ],
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