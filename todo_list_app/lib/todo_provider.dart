import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  Map<String, List<String>> dataBase = {};
  
  void addTodo(String title, String todo, String date){
    List<String> newList = [];
    newList.addAll([todo, date]);
    dataBase.putIfAbsent(title, () => newList);
    notifyListeners();
  }

  void removeTodo(String title){
    dataBase.remove(title);
    notifyListeners();
  }

  void updateTodo(String title){
    final todoUpdate = dataBase[title];
    
    notifyListeners();
  }
  
}