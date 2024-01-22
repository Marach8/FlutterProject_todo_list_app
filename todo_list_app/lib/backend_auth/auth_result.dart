import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


@immutable 
abstract class AuthenticationResult{
  const AuthenticationResult();
}


@immutable
class AuthSuccess extends AuthenticationResult{
  final String title;

  const AuthSuccess.fromFirebase()
    : title = 'Authentication Successfull!';
}

@immutable 
abstract class AuthError extends AuthenticationResult{
  final String title, content;
  
  const AuthError({
    required this.content, required this.title
  });

  factory AuthError.fromFirebase(
    FirebaseAuthException exception) 
    => authErrors[exception.code.trim().toLowerCase()]
    ?? const UnknownAuthError();
}


@immutable 
class UnknownAuthError extends AuthError{
  const UnknownAuthError(): super(
    title: 'Authentication Error!',
    content: 'Unknown Authentication Error!'
  );
}

@immutable 
class NoCurrentUserAuthError extends AuthError{
  const NoCurrentUserAuthError(): super(
    title: 'No Current User!',
    content: 'No Current user with this information was found!'
  );
}

@immutable 
class RequiresRecentLoginAuthError extends AuthError {
  const RequiresRecentLoginAuthError(): super(
    title: 'Requires Recent Login!',
    content: 'Please, logout and log back in to perform this operation!'
  );
}

@immutable 
class OperationNotAllowedAuthError extends AuthError {
  const OperationNotAllowedAuthError(): super(
    title: 'Operation Not Allowed!',
    content: 'Sorry, you cannot perform this operation at this moment!'
  );
}

@immutable 
class UserNotFoundAuthError extends AuthError{
  const UserNotFoundAuthError(): super(
    title: 'User Not Found!',
    content: 'This User was not found on the server!'
  );
}

@immutable 
class WeakPasswordAuthError extends AuthError{
  const WeakPasswordAuthError(): super(
    title: 'Weak Password!',
    content: 'Length of password is too short!'
  );
}

@immutable 
class EmailAlreadyInUseAuthError extends AuthError{
  const EmailAlreadyInUseAuthError(): super(
    title: 'Email Already In User!',
    content: 'Thei email is already registered! Please enter a new one!'
  );
}

@immutable 
class NetworkFailedAuthError extends AuthError{
  const NetworkFailedAuthError(): super(
    title: 'Network Request Failed!',
    content: 'Please check your Internet connection and try again!'
  );
}

@immutable 
class WrongPasswordAuthError extends AuthError{
  const WrongPasswordAuthError(): super(
    title: 'Incorrect Credentials!',
    content: 'Login Credentials are incorrect'
  );
}

@immutable 
class InvalidEmailAuthError extends AuthError{
  const InvalidEmailAuthError(): super(
    title: 'Invalid Email!',
    content: 'This email is invalid!'
  );
}

Map<String, AuthError> authErrors = {
  'user-not-found': const UserNotFoundAuthError(),
  'weak-password': const WeakPasswordAuthError(),
  'operation-not-allowed': const OperationNotAllowedAuthError(),
  'email-already-in-use': const EmailAlreadyInUseAuthError(),
  'requires-recent-login': const RequiresRecentLoginAuthError(),
  'no-current-user': const NoCurrentUserAuthError(),
  'network-request-failed': const NetworkFailedAuthError(),
  'wrong-password': const WrongPasswordAuthError(),
  'invalid-email': const InvalidEmailAuthError()
};