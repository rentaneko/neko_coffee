import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/account/bloc/index.dart';
import 'package:neko_coffee/models/customer.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final client = Supabase.instance.client;
  AccountBloc(AccountState initialState) : super(initialState) {
    on<InitialAccountEvent>(initialAccountEvent);

    on<LogoutButtonClickedEvent>(logoutButtonClickedEvent);
  }

  FutureOr<void> initialAccountEvent(
      InitialAccountEvent event, Emitter<AccountState> emit) async {
    if (client.auth.currentUser == null) {
      emit(NotLoggedAccountState());
    } else {
      emit(LoadingAccountState());
      CustomerModel user = CustomerModel();
      try {
        await client
            .from('Customer')
            .select()
            .eq('id', client.auth.currentUser!.id)
            .single()
            .then((value) => {
                  user = CustomerModel.fromJson(value),
                });
        emit(SuccessAccountState(user: user));
      } catch (e) {
        emit(ErrorAccountState(errorMsg: e.toString()));
      }
    }
  }

  FutureOr<void> logoutButtonClickedEvent(
      LogoutButtonClickedEvent event, Emitter<AccountState> emit) async {
    emit(LoadingAccountState());

    try {
      await client.auth.signOut();
      emit(NotLoggedAccountState());
    } catch (e) {
      emit(ErrorAccountState(errorMsg: e.toString()));
    }
  }
}
