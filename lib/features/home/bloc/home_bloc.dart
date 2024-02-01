import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/home/bloc/index.dart';
import 'package:neko_coffee/features/home/models/home_product_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  //

  final supabase = Supabase.instance.client;

  //
  HomeBloc(HomeInitializedState homeInitializedState)
      : super(const HomeInitializedState()) {
    on<HomeInitialEvent>(homeInitialEvent);

    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);

    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);

    on<HomeWishlistButtonNavigateEvent>(homeWishlistButtonNavigateEvent);

    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
  }

  //
  FutureOr<void> homeProductWishlistButtonClickedEvent(
    HomeProductWishlistButtonClickedEvent event,
    Emitter<HomeState> emitter,
  ) {
    print('Wishlist Product Clicked');
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
    HomeProductCartButtonClickedEvent event,
    Emitter<HomeState> emitter,
  ) {
    print('Cart Product Clicked');
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtonNavigateEvent event, Emitter<HomeState> emit) {
    supabase.auth.signOut();
    emit(HomeNavigateToWishlistScreenActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) async {
    if (supabase.auth.currentUser == null) {
      emit(HomeNavigateToLoginScreenActionState());
    } else {
      emit(HomeNavigateToCartScreenActionState());
    }
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    List<ProductDataModel> products = [];
    final supabase = Supabase.instance.client;
    await supabase
        .from('Product')
        .select('*')
        .filter('is_active', 'eq', 'true')
        .gte('quantity', '100')
        .then(
      (value) {
        products = value.map((e) => ProductDataModel.fromJson(e)).toList();
      },
    );

    emit(HomeLoadedSuccessState(products: products));
  }
}
