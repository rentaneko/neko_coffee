import 'package:flutter/material.dart';
import 'package:neko_coffee/features/home/models/home_product_data.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

abstract class HomeActionState extends HomeState {}

/// Initialized
class HomeInitializedState extends HomeState {
  const HomeInitializedState();
}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> products;

  const HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState {
  HomeErrorState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorHomeState';

  @override
  List<Object> get props => [errorMessage];
}

class HomeNavigateToWishlistScreenActionState extends HomeActionState {}

class HomeNavigateToCartScreenActionState extends HomeActionState {}

class HomeNavigateToLoginScreenActionState extends HomeActionState {}
