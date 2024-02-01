import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {}

class InitializedAuthEvent extends AuthEvent {}

class LoadAuthEvent extends AuthEvent {}

class UnauthorizedEvent extends AuthEvent {}

class AuthorizedEvent extends AuthEvent {}

class InputEmailEvent extends AuthEvent {
  final String email;

  InputEmailEvent({required this.email});
}

class InputPasswordEvent extends AuthEvent {
  final String password;

  InputPasswordEvent({required this.password});
}

class LoginButtonActionEvent extends AuthEvent {}

class WaitingAuthEvent extends AuthEvent {}
