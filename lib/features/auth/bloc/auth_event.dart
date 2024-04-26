part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthActionEvent extends AuthEvent {}

final class AuthSignUp extends AuthActionEvent {
  final String email;
  final String password;
  final String phone;
  final String fullname;

  AuthSignUp({
    required this.email,
    required this.password,
    required this.phone,
    required this.fullname,
  });
}

final class AuthLogin extends AuthActionEvent {
  final String email;
  final String password;

  AuthLogin({required this.email, required this.password});
}

final class AuthIsUserLoggedIn extends AuthEvent {}
