import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:neko_coffee/features/wishlist/bloc/index.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc(WishlistState initialState) : super(initialState) {
    on<WishlistEvent>((event, emit) {
      return emit.forEach<WishlistState>(
        event.applyAsync(currentState: state, bloc: this),
        onData: (state) => state,
        onError: (error, stackTrace) {
          developer.log('$error',
              name: 'WishlistBloc', error: error, stackTrace: stackTrace);
          return ErrorWishlistState(error.toString());
        },
      );
    });
  }
}
