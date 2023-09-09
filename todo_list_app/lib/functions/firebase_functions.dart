import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/custom_widgets/alert_widget.dart';

class FirebaseAuthRegister{
  final BuildContext context;
  FirebaseAuthRegister(this.context);

  Future<User?> firebaseRegister(String email, String password,) async{

    try{
      UserCredential userCredentials = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
      );
      //firebaseAlert('Registration Successful');
      //return userCredentials.user;
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password'){
        print('Weak password!');
        //firebaseAlert('Password must contain at least 6 characters!!!');
        //MaterialBannerAlert1(context).materialBannerAlert1(text, icon)
      } else if(e.code == 'email-already-in-use'){
        //firebaseAlert('This email is already registered!!!');
        print('User already exists!');
      }
    } catch (e){print(e.toString());}
  }
}

class FireBaseAuthLogin{

  Future<User?> firebaseLogin(String email, String password) async{
    try{
      UserCredential userCredentials = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password
      );
      return userCredentials.user;
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password'){
        print('The password is weak!');
      } else if(e.code == 'email-already-in-use'){
        print('User already exists!');
      }
    } catch (e){print(e.toString());}
  }
}
