import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/signup/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpBloc extends Bloc<SignupEvent, SignUpState> {
  final client = Supabase.instance.client;
  SignUpBloc(SignUpState initialState) : super(initialState) {
    on<InputEmailSignupEvent>(inputEmailSignupEvent);
    on<InputPasswordSignupEvent>(inputPasswordSignupEvent);
    on<SignUpButtonClickedEvent>(signupButtonClickedEvent);
  }

  FutureOr<void> inputEmailSignupEvent(
      InputEmailSignupEvent event, Emitter<SignUpState> emit) {
    if (event.email.length > 1 && event.email.length < 10) {
      emit(ErrorInputEmailSignUpState(
          errorMsg: 'Email should be at least 10 chars'));
    } else if (event.email.length > 30) {
      emit(ErrorInputEmailSignUpState(errorMsg: 'Email is too long'));
    } else {
      emit(ErrorInputEmailSignUpState(errorMsg: null));
    }
  }

  FutureOr<void> inputPasswordSignupEvent(
      InputPasswordSignupEvent event, Emitter<SignUpState> emit) {
    if (event.password.length > 1 && event.password.length < 8) {
      emit(ErrorInputPasswordSignUpState(
          errorMsg: 'Password should be at least 8 chars'));
    } else if (event.password.length > 20) {
      emit(ErrorInputPasswordSignUpState(errorMsg: 'Password is too long'));
    } else {
      emit(ErrorInputPasswordSignUpState(errorMsg: null));
    }
  }

  FutureOr<void> signupButtonClickedEvent(
      SignUpButtonClickedEvent event, Emitter<SignUpState> emit) async {
    emit(LoadingSignUpState());
    await client.auth
        .signUp(password: event.password, email: event.email)
        .then((value) {
      emit(SuccessSignUpState());
    });
  }
}
