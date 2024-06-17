part of 'product_detail_bloc.dart';

sealed class ProductDetailState {
  const ProductDetailState();
}

final class LoadingProductDetailState extends ProductDetailState {}

final class DisplayPoductDetailState extends ProductDetailState {
  final Product product;
  final Category category;

  DisplayPoductDetailState({required this.product, required this.category});
}

final class ErrorPoductDetailState extends ProductDetailState {
  final ServerError error;

  ErrorPoductDetailState({required this.error});
}
