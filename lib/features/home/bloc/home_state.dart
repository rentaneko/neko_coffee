import 'package:neko_coffee/models/cart.model.dart';
import 'package:neko_coffee/models/favourite.model.dart';
import 'package:neko_coffee/models/product.model.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

/// Initialized
class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class UnAuthenticatedHomeState extends HomeState {
  final List<ProductModel> products;

  UnAuthenticatedHomeState({required this.products});
}

class AuthenticatedHomeState extends HomeState {
  final List<ProductModel> products;
  final List<CartModel> cart;
  final List<FavouriteModel> favourites;

  AuthenticatedHomeState(
      {required this.products, required this.cart, required this.favourites});
}

class ErrorHomeState extends HomeState {
  ErrorHomeState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorHomeState';
}

class AddToCartClickedHomeState extends HomeActionState {}

class SuccessAddToCartHomeState extends HomeActionState {}

class HomeNavigateToCartActionState extends HomeActionState {}
