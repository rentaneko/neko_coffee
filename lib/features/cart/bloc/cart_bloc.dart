import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc(CartState initialState) : super(initialState) {
    on<CartEvent>((event, emit) {
      return emit.forEach<CartState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error',
              name: 'CartBloc', error: error, stackTrace: stackTrace);
          return ErrorCartState(error.toString());
        },
      );
    });
  }
}
