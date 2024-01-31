import 'package:flutter/material.dart';

@immutable
abstract class AuthenticationState {
  const AuthenticationState();
}

/// Initialized
class InitializedAuthState extends AuthenticationState {
  const InitializedAuthState();
}

class UnauthorizedState extends AuthenticationState {
  const UnauthorizedState();
}

class AuthorizedState extends AuthenticationState {
  const AuthorizedState(this.email, this.id);

  final String email;
  final String id;
}

class LoadingAuthState extends AuthenticationState {
  const LoadingAuthState();
}

class ErrorAuthState extends AuthenticationState {
  const ErrorAuthState(this.errorMessage);
  final String errorMessage;
}
