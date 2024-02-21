import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/contants/value.contant.dart';
import 'package:neko_coffee/features/login/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final client = Supabase.instance.client;
  LoginBloc(LoginState initialState) : super(initialState) {
    // on<InitialLoginEvent>(initialLoginEvent);

    on<InputEmailEvent>(inputEmailEvent);

    on<InputPasswordEvent>(inputPasswordEvent);

    on<LoginButtonClickedEvent>(loginButtonClickedEvent);
  }

  FutureOr<void> initialLoginEvent(
      InitialLoginEvent event, Emitter<LoginState> emit) async {
    final _pref = await SharedPreferences.getInstance();
    if (_pref.getString(IS_LOGIN) != null) {
    } else {}
  }

  FutureOr<void> inputEmailEvent(
      InputEmailEvent event, Emitter<LoginState> emit) {
    if (event.email.length > 1 && event.email.length < 12) {
      emit(ErrorInputEmailState(errorMsg: 'Email should be at least 12 chars'));
    } else if (event.email.length > 40) {
      emit(ErrorInputEmailState(errorMsg: 'Email is too long'));
    } else {
      emit(ErrorInputEmailState(errorMsg: null));
    }
  }

  FutureOr<void> inputPasswordEvent(
      InputPasswordEvent event, Emitter<LoginState> emit) {
    if (event.password.length > 1 && event.password.length < 6) {
      emit(ErrorInputPasswordState(
          errorMsg: 'Password should be at least 6 chars'));
    } else if (event.password.length > 20) {
      emit(ErrorInputPasswordState(errorMsg: 'Password is too long'));
    } else {
      emit(ErrorInputPasswordState(errorMsg: null));
    }
  }

  FutureOr<void> loginButtonClickedEvent(
      LoginButtonClickedEvent event, Emitter<LoginState> emit) async {
    emit(LoadingLoginState());
    try {
      await client.auth
          .signInWithPassword(password: event.password, email: event.email);
      emit(SuccessLoginState());
    } catch (e) {
      emit(ErrorLoginState(errorMsg: 'Invalid login credentials'));
    }
  }
}
