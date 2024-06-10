part of 'product_bloc.dart';

@immutable
sealed class ProductState {
  const ProductState();
}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class ProductFailure extends ProductState {
  final ServerError error;

  const ProductFailure(this.error);
}

final class ProductDisplaySuccess extends ProductState {
  final List<Product> products;
  const ProductDisplaySuccess({required this.products});
}
