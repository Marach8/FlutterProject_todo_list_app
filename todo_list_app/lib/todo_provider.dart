import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  List<List<String>> dataBase = [];

  TextEditingController controller1 = TextEditingController();  TextEditingController emailController = TextEditingController();
  TextEditingController controller2 = TextEditingController();  TextEditingController passwordController = TextEditingController();
  TextEditingController controller3 = TextEditingController();  TextEditingController usernameController = TextEditingController(); 

  @override
  void dispose(){controller1.dispose(); controller2.dispose(); controller3.dispose(); super.dispose();}
  
  void addTodo(){
    List<String> newList = [];    
    newList.addAll([controller1.text, controller2.text, controller3.text]);
    dataBase.add(newList);
    notifyListeners();
  }

  void updateTodo(String keyItem, String dateItem, String todoItem, int removeIndex){
    controller1.text = keyItem; controller2.text = dateItem; controller3.text = todoItem;
    dataBase.removeAt(removeIndex);
    notifyListeners();
  }

  void delete(int removeIndex){
    dataBase.removeAt(removeIndex);
    notifyListeners();
  }

  void undo(String keyItem, String dateItem, String todoItem, int insertIndex){
    List<String> newList = [keyItem, dateItem, todoItem];    
    dataBase.insert(insertIndex, newList);
    notifyListeners();
  }
  
}