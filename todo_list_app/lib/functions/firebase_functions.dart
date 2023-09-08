import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


Future<User?> firebaseRegister(String email, password) async{
  try{
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch(e){
    if (e.code == 'weak-password'){
      print('The password is weak!');
    } else if(e.code == 'email-already-in-use'){
      print('User already exists!');
    }
  } catch (e){print(e.toString());}
}