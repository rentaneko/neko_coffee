import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/usecase/add_to_cart.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final AddToCart _addToCart;
  CartBloc({required AddToCart addToCart})
      : _addToCart = addToCart,
        super(CartInitial()) {
    on<AddToCartEvent>(addToCartEvent);
  }

  FutureOr<void> addToCartEvent(
      AddToCartEvent event, Emitter<CartState> emit) async {
    final res = await _addToCart(
      AddToCartParams(
        idProduct: event.idProduct,
        idTopping: event.idTopping,
        iceType: event.iceType,
        variantType: event.variantType,
        sizeCup: event.sizeCup,
        sugarType: event.sugarType,
        quantity: event.quantity,
      ),
    );
    res.fold(
      (l) => emit(CartFailure(error: l)),
      (r) => emit(CartSuccess()),
    );
  }
}
