import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/auth/bloc/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthBloc extends Bloc<AuthEvent, AuthenticationState> {
  AuthBloc(InitializedAuthState initializedAuthState)
      : super(const InitializedAuthState()) {
    on<InitializedAuthEvent>(initializedAuthEvent);
  }

  FutureOr<void> initializedAuthEvent(
      InitializedAuthEvent event, Emitter<AuthenticationState> emit) async {
    emit(const LoadingAuthState());
    final supabase = Supabase.instance.client;
    if (supabase.auth.currentUser == null) {
      emit(const UnauthorizedState());
    } else {
      emit(AuthorizedState(
        supabase.auth.currentUser?.email ?? '',
        supabase.auth.currentUser!.id,
      ));
    }
  }
}
