import 'dart:async';
import 'dart:developer' as developer;

import 'package:neko_coffee/features/cart/bloc/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CartEvent {
  Stream<CartState> applyAsync({CartState currentState, CartBloc bloc});
}

class UnCartEvent extends CartEvent {
  @override
  Stream<CartState> applyAsync(
      {CartState? currentState, CartBloc? bloc}) async* {
    yield UnCartState();
  }
}

class LoadCartEvent extends CartEvent {
  @override
  Stream<CartState> applyAsync(
      {CartState? currentState, CartBloc? bloc}) async* {
    try {
      yield UnCartState();
      await Future.delayed(const Duration(seconds: 1));
      yield InCartState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadCartEvent', error: _, stackTrace: stackTrace);
      yield ErrorCartState(_.toString());
    }
  }
}
