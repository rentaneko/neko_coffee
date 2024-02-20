abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class ErrorLoginState extends LoginState {}

class ErrorInputEmailState extends LoginState {
  final String? errorMsg;

  ErrorInputEmailState({required this.errorMsg});
}

class ErrorInputPasswordState extends LoginState {
  final String? errorMsg;

  ErrorInputPasswordState({required this.errorMsg});
}

class SuccessLoginState extends LoginState {}
