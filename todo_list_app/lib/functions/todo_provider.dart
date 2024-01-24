import 'package:flutter/material.dart';
import 'package:todo_list_app/backend_auth/firebase_backend.dart';

class AppUsers extends ChangeNotifier{
  final backend = FirebaseBackend();
  late List<Map<String, dynamic>> dataBase;

  String? loggedInUser; 
  bool isInUpdateMode = false;
  // String initialTitle = ''; 
  // String initialDate = ''; 
  // String initialTodo = ''; 
  // int updateIndex = 0;  
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
  
  // void addTodo(int index){
  //   List<String> newList = [
  //     todoTitleController.text, 
  //     todoDateTimeController.text, 
  //     todoContentController.text
  //   ]; 
  //   dataBase.insert(index, newList);
  //   notifyListeners();
  // }

  // void updateTodo(
  //   String keyItem, 
  //   String dateItem, 
  //   String todoItem, 
  //   int removeIndex,
  // ){
  //   initialTitle = keyItem; 
  //   initialDate = dateItem; 
  //   initialTodo = todoItem; 
  //   updateIndex = removeIndex;
  //   todoTitleController.text = keyItem;
  //   todoDateTimeController.text = dateItem; 
  //   todoContentController.text = todoItem;
  //   dataBase.removeAt(removeIndex);
  //   notifyListeners();
  // }
  Map<String, dynamic> removefromLocal(int index){
    final deletedTodo = dataBase.removeAt(index);
    notifyListeners();
    return deletedTodo;
  }
  
  void revertDelete(int index, Map<String, dynamic> item) 
    => !dataBase.contains(item) ? dataBase.insert(index, item)
      : {};

  void deleteFromRemote(String titleToDelete){
    backend.deleteTodo(titleToDelete);
    notifyListeners();
  }

  // void undo(
  //   String keyItem,
  //   dateItem, 
  //   todoItem, 
  //   int insertIndex
  // ){
  //   List<String> newList = [keyItem, dateItem, todoItem];    
  //   dataBase.insert(insertIndex, newList);
  //   notifyListeners();
  // }

  void callToAction(VoidCallback action){
    action();
    notifyListeners();
  }
}