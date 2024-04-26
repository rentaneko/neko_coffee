part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthFailureState extends AuthState {
  final ServerError serverError;

  AuthFailureState({required this.serverError});
}

final class AuthSuccessState extends AuthState {
  final User user;

  AuthSuccessState({required this.user});
}

final class AuthUserIsNotLogged extends AuthState {}
