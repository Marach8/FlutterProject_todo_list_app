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
      FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({'username': username});
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
  final BuildContext context;
  FirebaseAuthLogin(this.context);

  firebaseLogin(String email, String password, void Function(String text, Color color) firebaseAlert) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password
      );
      firebaseAlert('Login Successful...', Colors.green);
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
      AppUsers().resetUser(userData['username']);
      print(userData['username']);
         
    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found'){
        firebaseAlert('This email is not registered!!!', Colors.red);
      } else if(e.code == 'wrong-password'){
        firebaseAlert('Incorrect login credentials!!!', Colors.red);
      }
    } catch (e){ print(e);
      firebaseAlert(e.toString(), Colors.red);
    }    
  }
}


class FirebaseAuthLogout{

  Future<void> firebaseLogout()async{
    await FirebaseAuth.instance.signOut();
  }
}
