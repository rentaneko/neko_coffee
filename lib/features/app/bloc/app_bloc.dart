import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/app/bloc/index.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final client = Supabase.instance.client;

  AppBloc(AppState initialState) : super(InitialAppState()) {
    on<InitialAppEvent>(initialAppEvent);
  }

  FutureOr<void> initialAppEvent(
      InitialAppEvent event, Emitter<AppState> emit) async {}
}
