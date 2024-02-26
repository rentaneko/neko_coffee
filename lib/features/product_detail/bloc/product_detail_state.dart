import 'package:neko_coffee/models/cart.model.dart';
import 'package:neko_coffee/models/product.model.dart';

abstract class ProductDetailState {}

class ProductDetailInitialState extends ProductDetailState {}

class ProductDetailLoadingState extends ProductDetailState {}

class ProductDetailLoadedState extends ProductDetailState {
  final ProductModel product;
  final List<CartModel> cart;

  ProductDetailLoadedState({required this.product, required this.cart});
}

class ProductDetailErrorState extends ProductDetailState {
  final String errorMsg;

  ProductDetailErrorState({required this.errorMsg});
}
