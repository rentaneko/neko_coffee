import 'package:neko_coffee/models/cart.model.dart';

abstract class CartState {}

abstract class CartActionState extends CartState {}

class InitialCartState extends CartState {}

class CartLoadingState extends CartState {}

class CartLoadedSuccessState extends CartState {
  final List<CartModel> cart;

  CartLoadedSuccessState({required this.cart});
}

class CartErrorState extends CartState {
  final String errorMsg;

  CartErrorState({required this.errorMsg});
}

class CartUpdateItemInCartState extends CartActionState {}
