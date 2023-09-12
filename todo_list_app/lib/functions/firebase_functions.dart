import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class FirebaseAuthRegister{
  final BuildContext context;
  FirebaseAuthRegister(this.context);

  Future<void> firebaseRegister(
    String username, String email, String password, void Function(String text, Color color) firebaseAlert
  ) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
      );
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({'username': username});
      //FirebaseFirestore.instance.collection('Users').doc(username).set({'title': {'date': '', 'content': ''}});
      firebaseAlert('Registration Successful...', Colors.green);
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password'){
        firebaseAlert('Password must contain at least 6 characters!!!', Colors.red);
      }
      else if(e.code == 'email-already-in-use'){
        firebaseAlert('This email is already registered!!!', Colors.red);
      }
    } catch (e){ firebaseAlert(e.toString(), Colors.red);}
  }
}


class FirebaseAuthLogin{
  final BuildContext? context;
  FirebaseAuthLogin(this.context);  
  final appUser = AppUsers();

  String resetUser(String text) => text;

  Future<String> firebaseLogin(String email, String password, Function(String text, Color color, IconData icon) firebaseAlert
  ) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password
      );      
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
      //AppUsers().resetUser = userData['username'];
      resetUser(userData['username']);
      await firebaseAlert('Login Successful...', Colors.green, Icons.check);
      return 'yes';
    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found'){
        await firebaseAlert('This email is not registered!!!', Colors.red, Icons.warning_rounded);
      } else if(e.code == 'wrong-password'){
        await firebaseAlert('Incorrect login credentials!!!', Colors.red, Icons.warning_rounded);
      }
      return 'no';
    } catch (e){
      await firebaseAlert(e.toString(), Colors.red, Icons.warning_rounded);
    }
    return 'no';
  }
}


class FirebaseAuthLogout{

  Future<void> firebaseLogout(
    Function(String text, Color color, IconData icon) firebaseAlert
  )async{
    await FirebaseAuth.instance.signOut();
    await firebaseAlert('LogOut Successful...', Colors.blue, Icons.check_box_rounded);
  }
}
