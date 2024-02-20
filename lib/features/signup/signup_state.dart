abstract class SignUpState {}

abstract class SignUpActionState extends SignUpState {}

class LoadingSignUpState extends SignUpState {}

class ErrorInputEmailSignUpState extends SignUpState {
  final String? errorMsg;

  ErrorInputEmailSignUpState({required this.errorMsg});
}

class ErrorInputPasswordSignUpState extends SignUpState {
  final String? errorMsg;

  ErrorInputPasswordSignUpState({required this.errorMsg});
}

class SuccessSignUpState extends SignUpState {}

class InitialSignUpState extends SignUpState {}
