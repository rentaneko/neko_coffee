import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/home/bloc/index.dart';
import 'package:neko_coffee/models/cart.model.dart';
import 'package:neko_coffee/models/product.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final client = Supabase.instance.client;
  List<CartModel> cart = [];
  List<ProductModel> products = [];
  HomeBloc(HomeState initialState) : super(initialState) {
    on<InitialHomeEvent>(initialHomeEvent);

    on<HomeMenuClickedEvent>(homeMenuClickedEvent);

    on<AddToCartClickedHomeEvent>(addToCartClickedHomeEvent);

    // on<GetItemCartHomeEvent>(getItemCartHomeEvent);
  }

  FutureOr<void> initialHomeEvent(
      InitialHomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());

    await client
        .from('Product')
        .select()
        .eq('is_active', true)
        .gte('quantity', 100)
        .then(
          (value) =>
              products = value.map((e) => ProductModel.fromJson(e)).toList(),
        );

    if (client.auth.currentUser == null) {
      emit(UnAuthenticatedHomeState(products: products));
    } else {
      await client
          .from('Cart')
          .select('*, Product(*)')
          .eq('id_user', client.auth.currentUser!.id)
          .then(
            (value) => {
              cart = value.map((e) => CartModel.fromJson(e)).toList(),
            },
          );
      emit(AuthenticatedHomeState(products: products, cart: cart));
    }
  }

  FutureOr<void> homeMenuClickedEvent(
      HomeMenuClickedEvent event, Emitter<HomeState> emit) async {
    List<ProductModel> products = [];
    emit(LoadingHomeState());

    if (event.idCate != 'All') {
      await client
          .from('Product')
          .select()
          .eq('is_active', true)
          .eq('id_category', event.idCate)
          .gte('quantity', 100)
          .then(
            (value) =>
                products = value.map((e) => ProductModel.fromJson(e)).toList(),
          );
    } else {
      await client
          .from('Product')
          .select()
          .eq('is_active', true)
          .gte('quantity', 100)
          .then(
            (value) =>
                products = value.map((e) => ProductModel.fromJson(e)).toList(),
          );
    }

    if (client.auth.currentUser == null) {
      emit(UnAuthenticatedHomeState(products: products));
    } else {
      List<CartModel> cart = [];
      await client
          .from('Cart')
          .select('*, Product(*)')
          .eq('id_user', client.auth.currentUser!.id)
          .then(
            (value) => cart = value.map((e) => CartModel.fromJson(e)).toList(),
          );
      emit(AuthenticatedHomeState(products: products, cart: cart));
    }
  }

  FutureOr<void> addToCartClickedHomeEvent(
      AddToCartClickedHomeEvent event, Emitter<HomeState> emit) async {
    emit(AddToCartClickedHomeState());
    try {
      await client.from('Cart').upsert(
        {
          'id_product': event.idProduct,
          'id_user': client.auth.currentUser!.id,
          'quantity': getQuantityInCartById(event.idProduct) + event.quantity,
        },

        // cant be update if duplicate primary key
        // ignoreDuplicates: true,
      );
      await client
          .from('Cart')
          .select('*, Product(*)')
          .eq('id_user', client.auth.currentUser!.id)
          .then(
            (value) => {
              cart = value.map((e) => CartModel.fromJson(e)).toList(),
            },
          );
      emit(AuthenticatedHomeState(products: products, cart: cart));
      emit(SuccessAddToCartHomeState());
    } catch (e) {
      print(e);
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
