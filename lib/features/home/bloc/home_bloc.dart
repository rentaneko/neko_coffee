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

    on<HomeMenuClickedEvent>(homeMenuClickedEvent);

    on<AddToCartClickedHomeEvent>(addToCartClickedHomeEvent);

    on<HomeCartButtonClickedEvent>(homeCartButtonClickedEvent);

    on<FavouriteButtonClickedEvent>(favouriteButtonClickedEvent);
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
          .order('Product(name)', ascending: true)
          .then(
            (value) => cart = value.map((e) => CartModel.fromJson(e)).toList(),
          );
      emit(AuthenticatedHomeState(
          products: products, cart: cart, favourites: favouriteList));
    }
  }

  FutureOr<void> addToCartClickedHomeEvent(
      AddToCartClickedHomeEvent event, Emitter<HomeState> emit) async {
    emit(AddToCartClickedHomeState());
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
            (value) => {
              cart = value.map((e) => CartModel.fromJson(e)).toList(),
            },
          );
      emit(AuthenticatedHomeState(
          products: products, cart: cart, favourites: favouriteList));
      emit(SuccessAddToCartHomeState());
    } catch (e) {
      // print(e);
    }
  }

  FutureOr<void> homeCartButtonClickedEvent(
      HomeCartButtonClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartActionState());
  }

  FutureOr<void> favouriteButtonClickedEvent(
      FavouriteButtonClickedEvent event, Emitter<HomeState> emit) async {
    try {
      if (isFavourite(event.idProduct)) {
        await client
            .from('Favourite')
            .delete()
            .eq('id_product', event.idProduct)
            .eq('id_user', client.auth.currentUser!.id);
      } else {
        await client.from('Favourite').insert({
          'id_product': event.idProduct,
          'id_user': client.auth.currentUser!.id,
        });
      }

      await client
          .from('Favourite')
          .select('*, Product(name, img_url, description)')
          .order('Product(name)')
          .then((value) => favouriteList =
              value.map((e) => FavouriteModel.fromJson(e)).toList());
      emit(AuthenticatedHomeState(
          products: products, cart: cart, favourites: favouriteList));
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
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

  bool isFavourite(String id) {
    for (var item in favouriteList) {
      if (item.idProduct == id) {
        return true;
      }
    }
    return false;
  }
}
