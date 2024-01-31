import 'dart:async';
import 'dart:developer' as developer;

import 'package:neko_coffee/features/wishlist/bloc/index.dart';
import 'package:meta/meta.dart';

@immutable
abstract class WishlistEvent {
  Stream<WishlistState> applyAsync(
      {WishlistState currentState, WishlistBloc bloc});
}

class UnWishlistEvent extends WishlistEvent {
  @override
  Stream<WishlistState> applyAsync(
      {WishlistState? currentState, WishlistBloc? bloc}) async* {
    yield UnWishlistState();
  }
}

class LoadWishlistEvent extends WishlistEvent {
  @override
  Stream<WishlistState> applyAsync(
      {WishlistState? currentState, WishlistBloc? bloc}) async* {
    try {
      yield UnWishlistState();
      await Future.delayed(const Duration(seconds: 1));
      yield InWishlistState('Hello world');
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadWishlistEvent', error: _, stackTrace: stackTrace);
      yield ErrorWishlistState(_.toString());
    }
  }
}
