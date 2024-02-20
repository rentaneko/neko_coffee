import 'package:flutter/cupertino.dart';

@immutable
abstract class LoginEvent {}

abstract class LoginActionEvent extends LoginEvent {}

class InputEmailEvent extends LoginEvent {
  final String email;

  InputEmailEvent({required this.email});
}

class InputPasswordEvent extends LoginEvent {
  final String password;

  InputPasswordEvent({required this.password});
}

class InitialLoginEvent extends LoginEvent {}
