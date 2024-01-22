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
  late User? currentUser;
  StreamController streamController = StreamController();


  Future<AuthenticationResult> registerUser(
    String username,
    String email,
    String password, 
  ) async{
    try{
      final userCredentials = await cloudAuth
      .createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      currentUser = userCredentials.user;
      final userPayload = UserPayload(
        username: username, 
        email: email, 
        password: password, 
        uid: currentUser!.uid
      );
      await cloudStore.collection('users').add(userPayload);
      return const AuthSuccess.fromFirebase();
    } on FirebaseAuthException catch(e){
      return AuthError.fromFirebase(e);
    } catch (_){
      return const UnknownAuthError();
    }
  }

  Future<AuthenticationResult> loginUser(
    String email,
    String password,
    dynamic user
  ) async{
    try{
      final userCredential = await cloudAuth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      currentUser = userCredential.user;
      final query = cloudStore.collection('users')
        .where('user-uid', isEqualTo: currentUser!.uid);
      final snapshots = await query.get();
      final document = snapshots.docs.first;
      final userDetails = document.data();
      user.callToAction(() => user.loggedInUser = userDetails['username']);
      return const AuthSuccess.fromFirebase();
    } on FirebaseAuthException catch(e){
      return AuthError.fromFirebase(e);
    } catch(_){
      return const UnknownAuthError();
    }
  }

  Future<AuthenticationResult> resetUserPassword(String email) async{
    try{
      await cloudAuth.sendPasswordResetEmail(email: email);
      return const AuthSuccess.fromFirebase();
    } on FirebaseAuthException catch(e){
      return AuthError.fromFirebase(e);
    } catch (_){
      return const UnknownAuthError();
    }
  }

  Future<AuthenticationResult> verifyUserEmail()async{
    final currentUser = FirebaseAuth.instance.currentUser;
    try{
      currentUser != null 
      ? await currentUser.sendEmailVerification() : {};
      return const AuthSuccess.fromFirebase();
    } on FirebaseAuthException catch(e){
      return AuthError.fromFirebase(e);
    } catch (_){
      return const UnknownAuthError();
    }
  }

  Future<AuthenticationResult> logoutUser() async{
    try{
      await cloudAuth.signOut();
      return const AuthSuccess.fromFirebase();
    } on FirebaseAuthException catch(e){
      return AuthError.fromFirebase(e);
    } catch (_){
      return const UnknownAuthError();
    }
  }

  dynamic getCurrentUserDetails(){
    try{
      
    }
  }
}