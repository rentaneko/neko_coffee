import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/home/bloc/index.dart';
import 'package:neko_coffee/models/cart.model.dart';
import 'package:neko_coffee/models/favourite.model.dart';
import 'package:neko_coffee/models/product.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final client = Supabase.instance.client;
  List<CartModel> cart = [];
  List<ProductModel> products = [];
  List<FavouriteModel> favouriteList = [];
  HomeBloc(HomeState initialState) : super(initialState) {
    on<InitialHomeEvent>(initialHomeEvent);

    on<ReloadingProductHomeEvent>(reloadingProductHomeEvent);

    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);
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
          .order('Product(name)', ascending: true)
          .then(
            (value) => {
              cart = value.map((e) => CartModel.fromJson(e)).toList(),
            },
          );

      await client
          .from('Favourite')
          .select('*, Product(name, img_url, description)')
          .order('Product(name)')
          .then((value) => favouriteList =
              value.map((e) => FavouriteModel.fromJson(e)).toList());

      emit(AuthenticatedHomeState(
        products: products,
        cart: cart,
        favourites: favouriteList,
      ));
    }
  }

  FutureOr<void> homeCartButtonClickedEvent(
      HomeCartButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> reloadingProductHomeEvent(
      ReloadingProductHomeEvent event, Emitter<HomeState> emit) async {
    try {
      await client
          .from('Product')
          .select()
          .eq('is_active', true)
          .gte('quantity', 100)
          .then(
            (value) =>
                products = value.map((e) => ProductModel.fromJson(e)).toList(),
          );
      await client
          .from('Cart')
          .select('*, Product(*)')
          .eq('id_user', client.auth.currentUser!.id)
          .order('Product(name)', ascending: true)
          .then(
            (value) => {
              cart = value.map((e) => CartModel.fromJson(e)).toList(),
            },
          );
      emit(AuthenticatedHomeState(
          products: products, cart: cart, favourites: favouriteList));
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }
}
