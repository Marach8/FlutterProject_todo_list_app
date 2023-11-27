import 'package:flutter/material.dart';

class AppUsers extends ChangeNotifier{

  List<List<String>> dataBase = [], wasteBin = [];

  TextEditingController todoTitleController = TextEditingController();  
  TextEditingController emailController = TextEditingController();
  TextEditingController todoDateTimeController = TextEditingController();  
  TextEditingController passwordController = TextEditingController();
  TextEditingController todoContentController = TextEditingController(); 
  TextEditingController usernameController = TextEditingController(); 
  TextEditingController forgotPasswordController = TextEditingController(); 
  TextEditingController confirmPassController = TextEditingController();
  String loggedInUser = ''; bool done = true;
  bool isInUpdateMode = false; String initialTitle = ''; String initialDate = ''; String initialTodo = ''; 
  int updateIndex = 0;  dynamic firebaseCurrentUser ;
  
  @override
  void dispose(){todoTitleController.dispose(); todoDateTimeController.dispose();
    todoContentController.dispose(); emailController.dispose(); 
    passwordController.dispose();  usernameController.dispose(); 
    confirmPassController.dispose(); forgotPasswordController.dispose(); 
    super.dispose();}
  
  void addTodo(int index){
    List<String> newList = [todoTitleController.text, todoDateTimeController.text, todoContentController.text]; 
    dataBase.insert(index, newList);
    notifyListeners();
  }

  void updateTodo(String keyItem, String dateItem, String todoItem, int removeIndex,){
    initialTitle = keyItem; initialDate = dateItem; initialTodo = todoItem; updateIndex = removeIndex;
    todoTitleController.text = keyItem; todoDateTimeController.text = dateItem; todoContentController.text = todoItem;
    dataBase.removeAt(removeIndex);
    notifyListeners();
  }

  void delete(String keyItem, String dateItem, String todoItem, int removeIndex,){
    wasteBin.add([keyItem, dateItem, todoItem]);
    dataBase.removeAt(removeIndex);
    notifyListeners();
  }

  void undo(String keyItem, dateItem, todoItem, int insertIndex){
    List<String> newList = [keyItem, dateItem, todoItem];    
    dataBase.insert(insertIndex, newList);
    notifyListeners();
  }
}