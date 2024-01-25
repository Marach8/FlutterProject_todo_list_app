import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';
import 'package:todo_list_app/constants/fonts_and_colors.dart';
import 'package:todo_list_app/constants/routes.dart';
import 'package:todo_list_app/custom_widgets/generic_dialog.dart';
import 'package:todo_list_app/custom_widgets/loading_screen/loading_screen.dart';
import 'package:todo_list_app/functions/extensions.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class PopUpMenuForMainView extends StatelessWidget {
  final BuildContext contextForLoadingScreen;

  const PopUpMenuForMainView({
    required this.contextForLoadingScreen, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final backend = FirebaseBackend();
    final loadingScreen = LoadingScreen();

    return Consumer<AppUsers>(
      builder: (_, user, __) => PopupMenuButton(
        offset: const Offset(0, 100),
        color: whiteColor,        
        onSelected: (value) async {                  
          if(value == 'logout'){
            await showGenericDialog(
              context: context,
              content: 'Dear ${user.loggedInUser}, are you sure you want to logout?',
              title: 'Logout',
              options: {
                'Cancel': false,
                'Logout': true
              }
            ).then((shouldLogOut) async {
              if(shouldLogOut == true){
                loadingScreen.showOverlay(
                  contextForLoadingScreen, 
                  'Logging out...'
                );
                await backend.logoutUser()
                .then((_) {
                  loadingScreen.hideOverlay();
                  Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                      loginPageRoute, (route) => false
                    );
                  }
                );
              }
            });                                       
          } 
          else if(value == 'deleteAccount'){
            await showGenericDialog(
              context: context,
              content: 'Dear ${user.loggedInUser}, are you sure you want to delete your account?',
              title: 'Delete Account',
              options: {
                'Cancel': false,
                'Delete Account': true
              }
            ).then((shouldDelete) async {
              if(shouldDelete == true){
                loadingScreen.showOverlay(
                  contextForLoadingScreen, 
                  'Deleting...'
                );
                await backend.deleteUserAccount()
                .then((_) {
                  loadingScreen.hideOverlay();
                  Navigator.of(context)
                    .pushNamedAndRemoveUntil(
                      loginPageRoute, (route) => false
                    );
                  }
                );
              }
            }); 
          }
        },
      
        itemBuilder: (context) => [
          PopupMenuItem(
            padding: const EdgeInsets.all(10),
            value:'logout', 
            height: 20, 
            child: const Text('Logout')
              .decorate(
                blackColor, 
                fontSize2, 
                fontWeight1
              ),
          ),
          PopupMenuItem(
            padding: const EdgeInsets.all(10),
            value:'deleteAccount', 
            height: 20, 
            child: const Text('Delete Account')
              .decorate(
                blackColor, 
                fontSize2, 
                fontWeight1
              ),
          ),
        ]
      ),
    );
  }
}




class PopUpMenuForTodosView extends StatelessWidget {
  final BuildContext contextForLoadingScreen;

  const PopUpMenuForTodosView({
    required this.contextForLoadingScreen, 
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final backend = FirebaseBackend();
    final loadingScreen = LoadingScreen();

    return Consumer<AppUsers>(
      builder: (_, user, __) => PopupMenuButton(
        offset: const Offset(0, 55),
        color: whiteColor,        
        onSelected: (value) async {                  
          if(value == 'deleteAll'){
            await showGenericDialog(
              context: context,
              content: 'Dear ${user.loggedInUser}, are you sure you want to delete all your todos?',
              title: 'Delete All Todos',
              options: {
                'Cancel': false,
                'Proceed': true
              }
            ).then((shouldDeleteAll) async {
              if(shouldDeleteAll == true){
                loadingScreen.showOverlay(
                  contextForLoadingScreen, 
                  'Deleting...'
                );
                await backend.deleteAllTodos()
                .then((_) {
                  loadingScreen.hideOverlay();
                  Navigator.pop(context);
                });
              }
            });                                       
          }
        },
      
        itemBuilder: (context) => [
          PopupMenuItem(
            value:'deleteAll', 
            height: 20, 
            child: const Text('Delete All Todos')
              .decorate(
                redColor, 
                fontSize2, 
                fontWeight1
              ),
          ),
        ]
      ),
    );
  }
}