import 'package:flutter/material.dart';

@immutable
abstract class SignupEvent {}

class InputEmailSignupEvent extends SignupEvent {
  final String email;

  InputEmailSignupEvent({required this.email});
}

class InputPasswordSignupEvent extends SignupEvent {
  final String password;

  InputPasswordSignupEvent({required this.password});
}

class SignUpButtonClickedEvent extends SignupEvent {
  final String email, password;

  SignUpButtonClickedEvent({required this.email, required this.password});
}
