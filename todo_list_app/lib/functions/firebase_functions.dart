import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthRegister{

  Future<void> firebaseRegister(
    String username, String email, String password, void Function(String text, Color color) firebaseAlert
  ) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
      );
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({'username': username});
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

  Future<String> firebaseLogin(String email, String password, Function(String text, Color color, IconData icon) firebaseAlert
  ) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password
      );
      User? user = FirebaseAuth.instance.currentUser;
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
      await firebaseAlert('Login Successful...', Colors.green, Icons.check);
      return userData['username'];
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

class FirebaseResetPassword{
  Future<String> resetPassword(
    email, void Function(String text, Color color, IconData icon) firebaseResetPasswordAlert
    ) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      firebaseResetPasswordAlert('Password Reset Link Sent To Email...', Colors.blue, Icons.check);
      return 'yes';
    } on FirebaseAuthException catch(e){
      if(e.code == 'invalid-email'){
        firebaseResetPasswordAlert('Email is invalid!!!', Colors.red, Icons.warning_rounded);
      }
      return 'no';
    } catch (e){return 'no';}
  }
}

class FirebaseGetUserDetails{

  Future<QuerySnapshot<Map<String, dynamic>>> getCurrentUser(String currentUser) async { 
    return await FirebaseFirestore.instance.collection(currentUser).get();
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

class FirestoreInteraction{
  Future<void> createTodo(String colName, String docName, Map<String, dynamic> info) async{
    await FirebaseFirestore.instance.collection(colName).doc(docName).set(info);
  }

  Future<void> deleteTodo(String colName, String docName) async{
    await FirebaseFirestore.instance.collection(colName).doc(docName).delete();
  }
}