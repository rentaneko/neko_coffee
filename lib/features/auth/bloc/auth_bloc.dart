import 'dart:async';
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/common/functions/validation.dart';
import 'package:neko_coffee/contants/value.contant.dart';
import 'package:neko_coffee/features/auth/bloc/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  final supabase = Supabase.instance.client;
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  late SharedPreferences _pref;

  AuthBloc(InitializedAuthState initializedAuthState)
      : super(const InitializedAuthState()) {
    on<InitializedAuthEvent>(initializedAuthEvent);

    on<InputEmailEvent>(inputEmailEvent);

    on<InputPasswordEvent>(inputPasswordEvent);

    on<LoginButtonActionEvent>(loginButtonActionEvent);

    on<WaitingAuthEvent>(waitingAuthEvent);
  }

  FutureOr<void> initializedAuthEvent(
      InitializedAuthEvent event, Emitter<AuthenticationState> emit) async {
    emit(const LoadingAuthState());
    if (supabase.auth.currentUser == null) {
      emit(const UnauthorizedState());
    } else {
      if (supabase.auth.currentSession!.isExpired) {
        supabase.auth.refreshSession();
        emit(AuthorizedState(
          supabase.auth.currentUser?.email ?? '',
          supabase.auth.currentUser!.id,
        ));
      }
    }
  }

  FutureOr<void> inputEmailEvent(
      InputEmailEvent event, Emitter<AuthenticationState> emit) {
    emailCtrl.text = event.email;
  }

  FutureOr<void> inputPasswordEvent(
      InputPasswordEvent event, Emitter<AuthenticationState> emit) {
    passwordCtrl.text = event.password;
  }

  FutureOr<void> loginButtonActionEvent(
      LoginButtonActionEvent event, Emitter<AuthenticationState> emit) async {
    if (emailCtrl.text.isEmpty && passwordCtrl.text.isEmpty) {
      emit(const ErrorAuthState('Email and password are required'));
    } else if (emailCtrl.text.isEmpty) {
      emit(const ErrorAuthState('Email is required'));
    } else if (passwordCtrl.text.isEmpty) {
      emit(const ErrorAuthState('Password is required'));
    } else if (!validateEmail(emailCtrl.text)) {
      emit(const ErrorAuthState('Email is invalid format'));
    } else if (passwordCtrl.text.length < 6 || passwordCtrl.text.length > 20) {
      emit(const ErrorAuthState('Password between 6-20 chars'));
    } else {
      await supabase.auth
          .signInWithPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      )
          .then((value) {
        if (value.user != null) {
          emit(SignInSuccessState());
        } else {
          emit(const ErrorAuthState('Email or Password incorrect !!!'));
        }
      });
    }
  }

  FutureOr<void> waitingAuthEvent(
      WaitingAuthEvent event, Emitter<AuthenticationState> emit) {
    emit(WaitingAuthState());
  }
}
