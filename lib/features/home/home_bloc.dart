import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/home/index.dart';
import 'package:neko_coffee/models/cart.model.dart';
import 'package:neko_coffee/models/category.model.dart';
import 'package:neko_coffee/models/product.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final client = Supabase.instance.client;
  HomeBloc(HomeState initialState) : super(initialState) {
    on<InitialHomeEvent>(initialHomeEvent);
  }

  FutureOr<void> initialHomeEvent(
      InitialHomeEvent event, Emitter<HomeState> emit) async {
    emit(LoadingHomeState());
    List<ProductModel> products = [];
    List<CategoryModel> cates = [];
    await client
        .from('Product')
        .select()
        .eq('is_active', true)
        .gte('quantity', 100)
        .then(
          (value) =>
              products = value.map((e) => ProductModel.fromJson(e)).toList(),
        );

    await client.from('Category').select().eq('is_active', true).then(
          (value) =>
              cates = value.map((e) => CategoryModel.fromJson(e)).toList(),
        );
    if (client.auth.currentUser == null) {
      emit(UnAuthenticatedHomeState(products: products, cates: cates));
    } else {
      List<CartModel> cart = [];
      await client
          .from('Cart')
          .select('*, Product(*)')
          .eq('id_user', client.auth.currentUser!.id)
          .then(
            (value) => cart = value.map((e) => CartModel.fromJson(e)).toList(),
          );
      emit(
          AuthenticatedHomeState(products: products, cates: cates, cart: cart));
    }
  }
}
