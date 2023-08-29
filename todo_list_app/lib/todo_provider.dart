import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  Map<String, List<String>> dataBase = {};
  
  void addTodo(String title, String date, String todo){
    List<String> newList = [];
    
    newList.addAll([date, todo]);
    dataBase.putIfAbsent(title, () => newList);
    notifyListeners();
  }
  // void viewTodo(){

  // }

  // void removeTodo(String title){
  //   dataBase.remove(title);
  //   notifyListeners();
  // }

  // void updateTodo(String title){
  //   final todoUpdate = dataBase[title];
        
  //   notifyListeners();
  // }
  
}