import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/cart/bloc/index.dart';
import 'package:neko_coffee/features/home/bloc/home_event.dart';
import 'package:neko_coffee/models/cart.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final client = Supabase.instance.client;
  double amount = 0.0;
  List<CartModel> cart = [];
  CartBloc(CartState initialState) : super(InitialCartState()) {
    on<InitialCartEvent>(initialCartEvent);

    on<UpdateQuantityItemCartEvent>(updateQuantityItemCartEvent);
  }

  FutureOr<void> initialCartEvent(
      InitialCartEvent event, Emitter<CartState> emit) async {
    emit(CartLoadingState());
    try {
      await client
          .from('Cart')
          .select('*, Product(*)')
          .eq('id_user', client.auth.currentUser!.id)
          .then(
            (value) => {
              cart = value.map((e) => CartModel.fromJson(e)).toList(),
            },
          );
      getTotal();
      emit(CartLoadedSuccessState(cart: cart));
    } catch (e) {
      emit(CartErrorState(errorMsg: e.toString()));
    }
  }

  FutureOr<void> updateQuantityItemCartEvent(
      UpdateQuantityItemCartEvent event, Emitter<CartState> emit) async {
    emit(CartUpdateItemInCartState());
    try {
      if (getQuantityInCartById(event.idProduct) == 1 && event.quantity == -1) {
        await client.from('Cart').delete().eq('id_product', event.idProduct);
      } else {
        await client.from('Cart').upsert(
          {
            'id_product': event.idProduct,
            'id_user': client.auth.currentUser!.id,
            'quantity': getQuantityInCartById(event.idProduct) + event.quantity,
          },
          // cant be update if duplicate primary key
          // ignoreDuplicates: true,
        );
      }
      await client
          .from('Cart')
          .select('*, Product(*)')
          .eq('id_user', client.auth.currentUser!.id)
          .order('Product(name)', ascending: true)
          .then(
        (value) {
          cart = value.map((e) => CartModel.fromJson(e)).toList();
        },
      );

      getTotal();
      event.homeBloc.add(ReloadingProductHomeEvent());
      emit(CartLoadedSuccessState(cart: cart));
    } catch (e) {
      emit(CartErrorState(errorMsg: e.toString()));
    }
  }

  void getTotal() {
    amount = 0.0;
    for (var item in cart) {
      amount += (item.price! * item.quantity!);
    }
  }

  int getQuantityInCartById(String id) {
    for (var item in cart) {
      if (item.idProduct == id) {
        return item.quantity!;
      }
    }
    return 0;
  }
}
