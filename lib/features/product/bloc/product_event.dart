part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class FetchAllProduct extends ProductEvent {}

final class FilterProduct extends ProductEvent {
  final SortType? price;
  final bool? isPromo;
  final List<Product> products;

  FilterProduct({this.price, this.isPromo, required this.products});
}
