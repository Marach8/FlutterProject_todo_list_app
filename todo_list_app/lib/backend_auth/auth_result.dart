import 'package:flutter/material.dart';


@immutable 
abstract class AuthResult{
  final String title, content;
  
  const AuthResult({
    required this.content, required this.title
  });

  factory AuthResult.fromBackend(dynamic exception) 
    => authResult[exception.trim().toLowerCase()]
    ?? const UnknownAuthError();
}


@immutable 
class UnknownAuthError extends AuthResult{
  const UnknownAuthError(): super(
    title: 'Authentication Error!',
    content: 'Unknown Authentication Error!'
  );
}

@immutable 
class NoCurrentUserAuthError extends AuthResult{
  const NoCurrentUserAuthError(): super(
    title: 'No Current User!',
    content: 'No Current user with this information was found!'
  );
}

@immutable 
class RequiresRecentLoginAuthError extends AuthResult {
  const RequiresRecentLoginAuthError(): super(
    title: 'Requires Recent Login!',
    content: 'Please, logout and log back in to perform this operation!'
  );
}

@immutable 
class OperationNotAllowedAuthError extends AuthResult {
  const OperationNotAllowedAuthError(): super(
    title: 'Operation Not Allowed!',
    content: 'Sorry, you cannot perform this operation at this moment!'
  );
}

@immutable 
class UserNotFoundAuthError extends AuthResult{
  const UserNotFoundAuthError(): super(
    title: 'User Not Found!',
    content: 'This User was not found on the server!'
  );
}

@immutable 
class WeakPasswordAuthError extends AuthResult{
  const WeakPasswordAuthError(): super(
    title: 'Weak Password!',
    content: 'Length of password is too short!'
  );
}

@immutable 
class EmailAlreadyInUseAuthError extends AuthResult{
  const EmailAlreadyInUseAuthError(): super(
    title: 'Email Already In User!',
    content: 'Thei email is already registered! Please enter a new one!'
  );
}

@immutable 
class NetworkFailedAuthError extends AuthResult{
  const NetworkFailedAuthError(): super(
    title: 'Network Request Failed!',
    content: 'Please check your Internet connection and try again!'
  );
}

@immutable 
class WrongPasswordAuthError extends AuthResult{
  const WrongPasswordAuthError(): super(
    title: 'Incorrect Credentials!',
    content: 'Login Credentials are incorrect'
  );
}

@immutable 
class InvalidEmailAuthError extends AuthResult{
  const InvalidEmailAuthError(): super(
    title: 'Invalid Email!',
    content: 'This email is invalid!'
  );
}

@immutable 
class UserNotVerifiedAuthError extends AuthResult{
  const UserNotVerifiedAuthError(): super(
    title: '',
    content: 'User not verified!'
  );
}

@immutable 
class SuccessfulAuthentication extends AuthResult{
  const SuccessfulAuthentication(): super(
    title: 'Success...',
    content: 'Authentication Successful...'
  );
}


Map<String, AuthResult> authResult= {
  'user-not-found': const UserNotFoundAuthError(),
  'user-not-verified': const UserNotVerifiedAuthError(),
  'weak-password': const WeakPasswordAuthError(),
  'operation-not-allowed': const OperationNotAllowedAuthError(),
  'email-already-in-use': const EmailAlreadyInUseAuthError(),
  'requires-recent-login': const RequiresRecentLoginAuthError(),
  'no-current-user': const NoCurrentUserAuthError(),
  'network-request-failed': const NetworkFailedAuthError(),
  'wrong-password': const WrongPasswordAuthError(),
  'invalid-email': const InvalidEmailAuthError(),
  'success': const SuccessfulAuthentication()
};