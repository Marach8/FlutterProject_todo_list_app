import 'package:flutter/material.dart';


@immutable 
abstract class AuthResult{
  final String content;
  
  const AuthResult({
    required this.content,
  });

  factory AuthResult.fromBackend(dynamic exception) 
    => authResult[exception.trim().toLowerCase()]
    ?? const UnknownAuthError();
}


@immutable 
class UnknownAuthError extends AuthResult{
  const UnknownAuthError(): super(
    content: 'Unknown Authentication Error!'
  );
}

@immutable 
class NoCurrentUserAuthError extends AuthResult{
  const NoCurrentUserAuthError(): super(
    content: 'No Current user with this information was found!'
  );
}

@immutable 
class RequiresRecentLoginAuthError extends AuthResult {
  const RequiresRecentLoginAuthError(): super(
    content: 'Please, logout and log back in to perform this operation!'
  );
}

@immutable 
class OperationNotAllowedAuthError extends AuthResult {
  const OperationNotAllowedAuthError(): super(
    content: 'Sorry, you cannot perform this operation at this moment!'
  );
}

@immutable 
class UserNotFoundAuthError extends AuthResult{
  const UserNotFoundAuthError(): super(
    content: 'This User was not found on the server!'
  );
}

@immutable 
class WeakPasswordAuthError extends AuthResult{
  const WeakPasswordAuthError(): super(
    content: 'Length of password is too short!'
  );
}

@immutable 
class EmailAlreadyInUseAuthError extends AuthResult{
  const EmailAlreadyInUseAuthError(): super(
    content: 'Thei email is already registered! Please enter a new one!'
  );
}

@immutable 
class NetworkFailedAuthError extends AuthResult{
  const NetworkFailedAuthError(): super(
    content: 'Please check your Internet connection and try again!'
  );
}

@immutable 
class WrongPasswordAuthError extends AuthResult{
  const WrongPasswordAuthError(): super(
    content: 'Login Credentials are incorrect'
  );
}

@immutable 
class InvalidEmailAuthError extends AuthResult{
  const InvalidEmailAuthError(): super(
    content: 'This email is invalid!'
  );
}

@immutable 
class UserNotVerifiedAuthError extends AuthResult{
  const UserNotVerifiedAuthError(): super(
    content: 'Your email is not Verified!'
  );
}

@immutable 
class SuccessfulAuthentication extends AuthResult{
  const SuccessfulAuthentication(): super(
    content: 'Authentication Successful...'
  );
}


Map<String, AuthResult> authResult = {
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