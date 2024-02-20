import 'package:neko_coffee/models/cart.model.dart';
import 'package:neko_coffee/models/category.model.dart';
import 'package:neko_coffee/models/product.model.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

/// Initialized
class InitialHomeState extends HomeState {}

class LoadingHomeState extends HomeState {}

class UnAuthenticatedHomeState extends HomeState {
  final List<ProductModel> products;
  final List<CategoryModel> cates;

  UnAuthenticatedHomeState({required this.products, required this.cates});
}

class AuthenticatedHomeState extends HomeState {
  final List<ProductModel> products;
  final List<CategoryModel> cates;
  final List<CartModel> cart;

  AuthenticatedHomeState(
      {required this.products, required this.cates, required this.cart});
}

class ErrorHomeState extends HomeState {
  ErrorHomeState(this.errorMessage);

  final String errorMessage;

  @override
  String toString() => 'ErrorHomeState';
}

class HomeMenuClickedState extends HomeActionState {
  final List<ProductModel> products;

  HomeMenuClickedState({required this.products});
}
