import 'package:flutter/material.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';

class AppUsers extends ChangeNotifier{
  final backend = FirebaseBackend();
  late List<Map<String, dynamic>> dataBase;
  late Map<String, dynamic> deletedTodo, todoToUpdate;
  String? loggedInUser; 
  bool isInUpdateMode = false;
  bool forgotPassword = false;
  bool isRegistered = true;
  bool obscureText = true;

  TextEditingController todoTitleController = TextEditingController();  
  TextEditingController emailController = TextEditingController();
  TextEditingController todoDateTimeController = TextEditingController();  
  TextEditingController passwordController = TextEditingController();
  TextEditingController todoContentController = TextEditingController(); 
  TextEditingController usernameController = TextEditingController(); 
  TextEditingController forgotPasswordController = TextEditingController(); 
  TextEditingController confirmPassController = TextEditingController();
  
  @override
  void dispose(){
    todoTitleController.dispose(); 
    todoDateTimeController.dispose();
    todoContentController.dispose(); 
    emailController.dispose(); 
    passwordController.dispose();  
    usernameController.dispose(); 
    confirmPassController.dispose(); 
    forgotPasswordController.dispose();
    super.dispose();
  }
  
  void deletefromLocal(int index) =>
    deletedTodo = dataBase.removeAt(index);
    
  void revertDelete(int index){
    !dataBase.contains(deletedTodo)
      ? dataBase.insert(index, deletedTodo)
      : {};
    notifyListeners();
  }

  void populateTodoFields(){
    todoTitleController.text = todoToUpdate['title'];
    todoDateTimeController.text = todoToUpdate['due-datetime'];
    todoContentController.text = todoToUpdate['content'];
  }

  void deleteFromRemote() =>
    backend.deleteTodo(deletedTodo['title']);

  void callToAction(VoidCallback action){
    action();
    notifyListeners();
  }
}