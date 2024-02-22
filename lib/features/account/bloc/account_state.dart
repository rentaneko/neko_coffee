import 'package:neko_coffee/models/customer.model.dart';

abstract class AccountState {}

abstract class AccountActionState extends AccountState {}

class InitialAccountState extends AccountState {}

class LoadingAccountState extends AccountState {}

class SuccessAccountState extends AccountState {
  final CustomerModel user;

  SuccessAccountState({required this.user});
}

class ErrorAccountState extends AccountState {
  final String errorMsg;

  ErrorAccountState({required this.errorMsg});
}

class NotLoggedAccountState extends AccountState {}

class LogoutButtonClickedState extends AccountActionState {}

class LogoutSuccessState extends AccountState {}
