import 'package:flutter/material.dart';

class User extends ChangeNotifier{
  Map<String, List> dataBase = {};

  TextEditingController controller1 = TextEditingController();  TextEditingController mobileEmailController = TextEditingController();
  TextEditingController controller2 = TextEditingController();  TextEditingController passwordController = TextEditingController();
  TextEditingController controller3 = TextEditingController();  TextEditingController usernameController = TextEditingController(); 
  TextEditingController controllerA = TextEditingController();  TextEditingController controllerB = TextEditingController();
  TextEditingController confirmPassController = TextEditingController(); String? loggedInUser;

  @override
  void dispose(){controller1.dispose(); controller2.dispose(); controller3.dispose(); mobileEmailController.dispose(); super.dispose();
    passwordController.dispose();  usernameController.dispose();  confirmPassController.dispose(); controllerA.dispose(); 
    controllerB.dispose(); 
  }
  
  void addTodo(){
    List<String> newList = [controller1.text, controller2.text, controller3.text];    
    //newList.addAll([controller1.text, controller2.text, controller3.text]);
    dataBase[loggedInUser]![2].addAll(newList);
    notifyListeners();
  }

  void updateTodo(String keyItem, String dateItem, String todoItem, int removeIndex){
    controller1.text = keyItem; controller2.text = dateItem; controller3.text = todoItem;
    dataBase[loggedInUser]![2].removeAt(removeIndex);
    notifyListeners();
  }

  void delete(int removeIndex){
    dataBase[loggedInUser]![2].removeAt(removeIndex);
    notifyListeners();
  }

  void undo(String keyItem, String dateItem, String todoItem, int insertIndex){
    List<String> newList = [keyItem, dateItem, todoItem];    
    dataBase[loggedInUser]![2].insert(insertIndex, newList);
    notifyListeners();
  }

  void register(String mobileEmail, String username, String password){
    List newList = [username, password, []];
    //newList.addAll([username, password, []]);
    dataBase.putIfAbsent(mobileEmail, () => newList);
    notifyListeners();
  }
  
  void login(String mobileEmail){
    loggedInUser = mobileEmail;
    notifyListeners();
  }
}