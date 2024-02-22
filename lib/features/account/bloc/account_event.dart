import 'package:flutter/material.dart';

@immutable
abstract class AccountEvent {}

class InitialAccountEvent extends AccountEvent {}

class LogoutButtonClickedEvent extends AccountEvent {}
