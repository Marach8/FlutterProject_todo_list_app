import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_app/backend_auth/auth_result.dart';
import 'package:todo_list_app/data_payload.dart';

class FirebaseBackend{
  FirebaseBackend._sharedInstance();
  static final FirebaseBackend _shared = FirebaseBackend._sharedInstance();
  factory FirebaseBackend() => _shared;

  final cloudAuth = FirebaseAuth.instance;
  final cloudStore = FirebaseFirestore.instance;

  User? get currentUser => cloudAuth.currentUser;

  Future<AuthResult> registerUser(
    String username,
    String email,
    String password, 
  ) async{
    try{
      await cloudAuth
      .createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      final userPayload = UserPayload(
        username: username, 
        email: email, 
        password: password, 
        uid: currentUser!.uid
      );
      await cloudStore.collection('Users').add(userPayload);
      await verifyUserEmail();
      return AuthResult.fromBackend('success');
    } on FirebaseAuthException catch(e){
      return AuthResult.fromBackend(e.code);
    } catch (_){
      return const UnknownAuthError();
    }
  }


  Future<AuthResult> loginUser(
    String email,
    String password,
    dynamic user
  ) async{
    try{
      await cloudAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      if(currentUser!.emailVerified){
        final query = cloudStore.collection('Users')
          .where('user-uid', isEqualTo: currentUser!.uid);
        final snapshots = await query.get();
        final document = snapshots.docs.first;
        final userDetails = document.data();
        user.callToAction(() => user.loggedInUser = userDetails['username']);
        return AuthResult.fromBackend('success');
      }
      return const UserNotVerifiedAuthError();
    } on FirebaseAuthException catch(e){
      return AuthResult.fromBackend(e.code);
    } catch(_){
      return const UnknownAuthError();
    }
  }


  Future<AuthResult> resetUserPassword(String email) async{
    try{
      await cloudAuth.sendPasswordResetEmail(email: email);
      return AuthResult.fromBackend('success');
    } on FirebaseAuthException catch(e){
      return AuthResult.fromBackend(e.code);
    } catch (_){
      return const UnknownAuthError();
    }
  }


  Future<AuthResult> verifyUserEmail()async{

    try{
      currentUser != null 
      ? await currentUser!.sendEmailVerification() : {};
      return AuthResult.fromBackend('success');
    } on FirebaseAuthException catch(e){
      return AuthResult.fromBackend(e.code);
    } catch (_){
      return const UnknownAuthError();
    }
  }


  Future<AuthResult> logoutUser() async{
    try{
      await cloudAuth.signOut();
      return AuthResult.fromBackend('success');
    } on FirebaseAuthException catch(e){
      return AuthResult.fromBackend(e.code);
    } catch (_){
      return const UnknownAuthError();
    }
  }


  Future<String> deleteUserAccount() async{
    await deleteAllTodos();
    try{
      await cloudStore.collection('Users')
        .where('user-uid', isEqualTo: currentUser!.uid)
        .get()
        .then((snapshot){
          snapshot.docs.first.reference.delete();
        });
      currentUser!.delete();
      return 'User Deleted.';
    } catch (_){
      return 'Could not Delete User';
    }
  }


  Future<String> uploadTodo(
    String title,
    String dueDateTime,
    String content
  )async{
    try{
      final todoPayload = TodoPayload(
        title: title, 
        dueDateTime: dueDateTime, 
        content: content, 
        uid: currentUser!.uid
      );
      await cloudStore.collection('Todos')
        .add(todoPayload);
      return 'success';
    } catch(e){
      return e.toString();
    }
  }


  Future<void> deleteTodo(String titleOfTodo) async {
    try{
      await cloudStore.collection('Todos')
        .where('title', isEqualTo: titleOfTodo)
        .get()
        .then((snapshot){
          snapshot.docs.first.reference.delete();
        });
    } catch(_){
      
    }
  }


  Future<void> deleteAllTodos() async {
    try{
      await cloudStore.collection('Todos')
        .where('user-uid', isEqualTo: currentUser!.uid)
        .get()
        .then((snapshot){
          final documents = snapshot.docs;
          for(final document in documents){
            document.reference.delete();
          }
        });
    } catch(_){

    }
  }


  Stream<QuerySnapshot<Map<String, dynamic>>> getCurrentUserTodos() 
  => cloudStore.collection('Todos')
    .where('user-uid', isEqualTo: currentUser!.uid)
    .snapshots();
}