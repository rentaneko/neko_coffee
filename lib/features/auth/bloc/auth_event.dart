import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {}

class InitializedAuthEvent extends AuthEvent {}

class LoadAuthEvent extends AuthEvent {}

class UnauthorizedEvent extends AuthEvent {}

class AuthorizedEvent extends AuthEvent {}
