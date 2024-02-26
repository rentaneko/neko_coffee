import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/product_detail/bloc/index.dart';
import 'package:neko_coffee/models/cart.model.dart';
import 'package:neko_coffee/models/product.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final client = Supabase.instance.client;

  List<CartModel> cart = [];
  ProductModel product = ProductModel();
  ProductDetailBloc(ProductDetailState initialState)
      : super(ProductDetailInitialState()) {
    on<ProductDetailInitialEvent>(productDetailInitialEvent);
  }

  FutureOr<void> productDetailInitialEvent(
      ProductDetailInitialEvent event, Emitter<ProductDetailState> emit) async {
    emit(ProductDetailLoadingState());
    try {
      await client
          .from('Product')
          .select()
          .eq('id', event.idProduct)
          .single()
          .then((value) => {
                product = ProductModel.fromJson(value),
              });
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
      emit(ProductDetailLoadedState(product: product, cart: cart));
    } catch (e) {
      emit(ProductDetailErrorState(errorMsg: e.toString()));
    }
  }
}
