import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_app/functions/todo_provider.dart';

class FirebaseAuthRegister{
  // final BuildContext context;
  // FirebaseAuthRegister(this.context);

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

// class FirebaseGetUserDetails{

//   QuerySnapshot getCurrentUser(String currentUser){
//     try{
//       //User? user = FirebaseAuth.instance.currentUser;
//       //await Future.delayed(const Duration(seconds:3), () 
//       FirebaseFirestore.instance.collection(currentUser).snapshots().docs;
      
//       // return userData;
//     } catch (e){
//       //return e.toString();
//       print('This is the error ${e.toString()}');
//     }
//   }
// }


class FirebaseAuthLogout{

  Future<void> firebaseLogout(
    Function(String text, Color color, IconData icon) firebaseAlert
  )async{
    await FirebaseAuth.instance.signOut();
    await firebaseAlert('LogOut Successful...', Colors.blue, Icons.check_box_rounded);
  }
}
