import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  Map<String, List<String>> dataBase = {};

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();  

  @override
  void dispose(){
    controller1.dispose(); controller2.dispose(); controller3.dispose(); super.dispose();
  }
  
  void addTodo(){
    List<String> newList = [];
    
    newList.addAll([controller2.text, controller3.text]);
    dataBase.putIfAbsent(controller1.text, () => newList);
    notifyListeners();
  }

  void updateTodo(String keyItem, String dateItem, String todoItem){
    controller1.text = keyItem; controller2.text = dateItem; controller3.text = todoItem;
    dataBase.remove(keyItem);
    notifyListeners();
  }

  void readTodo(){
    
  }
  
}