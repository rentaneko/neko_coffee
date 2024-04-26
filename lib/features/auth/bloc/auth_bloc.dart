import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/core/common/cubit/app_user_cubit.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/usecase/current_user.dart';
import 'package:neko_coffee/domain/usecase/usecase_login.dart';
import 'package:neko_coffee/domain/usecase/usecase_sign_up.dart';

import '../../../core/entities/user.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitialState()) {
    on<AuthEvent>((_, emit) => AuthLoadingState());
    on<AuthSignUp>(authSignUp);
    on<AuthLogin>(authLogin);
    on<AuthIsUserLoggedIn>(authIsUserLoggedIn);
  }

  FutureOr<void> authSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(UserSignUpParams(
      email: event.email,
      password: event.password,
      phone: event.phone,
      fullname: event.fullname,
    ));
    res.fold(
      (error) => emit(AuthFailureState(serverError: error)),
      (user) => emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> authLogin(AuthLogin event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );

    res.fold(
      (failure) => emit(AuthFailureState(serverError: failure)),
      (user) => emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> authIsUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthInitialState());
    final res = await _currentUser(NoParams());
    res.fold(
      (_) => emit(AuthUserIsNotLogged()),
      (user) => emitAuthSuccess(user, emit),
    );
  }

  FutureOr<void> emitAuthSuccess(User user, Emitter<AuthState> emit) async {
    _appUserCubit.updateUser(user);
    emit(AuthSuccessState(user: user));
  }
}
