import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthRegister{

  Future<String> firebaseRegister(
    String username, String email, String password, Function(String text, Color color, IconData icon) firebaseAlert
  ) async{
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
      );
      await FirebaseFirestore.instance.collection('Users').doc(userCredential.user!.uid).set({'username': username});
      await firebaseAlert('Registration Successful...', Colors.green, Icons.check);
      return 'yes';
    } on FirebaseAuthException catch(e){
      if (e.code == 'weak-password'){
        await firebaseAlert('Password must contain at least 6 characters!!!', Colors.red, Icons.warning_rounded);
      }
      else if(e.code == 'email-already-in-use'){
        await firebaseAlert('This email is already registered!!!', Colors.red, Icons.warning_rounded);
      }
      return 'no';
    } catch (e){
      await firebaseAlert(
        "Registration Failed!!! Please Check Your Network Connection And Try Again.", Colors.red, Icons.error_rounded
      );
      return 'no';
    }
  }
}


class FirebaseEmailVerification{
  Future<void> verifyEmail(Function(String text, Color color, IconData icon) firebaseAlert) async{
    try{
      final registeredUser = FirebaseAuth.instance.currentUser;
      await registeredUser!.sendEmailVerification();
      await firebaseAlert(
        'EMAIL NOT VERIFIED!!! An Email Verification Link has been sent to your email. Please, go and verify your email!', 
        Colors.red, Icons.warning_rounded
      );
    } catch (e){
      await firebaseAlert(
        'An Error Occured!!! Please Check Your Network Connection And Try Again.', Colors.red, Icons.cancel_rounded
      );
    }   
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
      if (user!.emailVerified){
        DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore.instance.collection('Users').doc(user!.uid).get();
        await firebaseAlert('Login Successful...', Colors.green, Icons.check);
        return userData['username'];
      } else {return 'email not verified';}

    } on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found'){
        await firebaseAlert('This email is not registered!!!', Colors.red, Icons.warning_rounded);
      } else if(e.code == 'wrong-password'){
        await firebaseAlert('Incorrect login credentials!!!', Colors.red, Icons.cancel_rounded);
      }
      return 'no';

    } catch (e){
      await firebaseAlert("Unable To Login!!! Please Check Your Network Connection And Try Again.", Colors.red, Icons.cancel_rounded);
      return 'no';
    }
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
  Future<dynamic> firebaseCurrentUser() async{
    User? user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<List<dynamic>> getCurrentUserDetails() async { 
    User? firebaseCurrentUser = FirebaseAuth.instance.currentUser;
    final username = await FirebaseFirestore.instance.collection('Users').doc(firebaseCurrentUser!.uid).get();
    final userDetails = await FirebaseFirestore.instance.collection(firebaseCurrentUser.uid).get();
    return [username, userDetails, firebaseCurrentUser];
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