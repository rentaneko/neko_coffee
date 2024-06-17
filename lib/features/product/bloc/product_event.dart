part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

final class FetchAllProduct extends ProductEvent {}

final class FilterProduct extends ProductEvent {
  final SortType? price;
  final bool isPromo;
  final List<Product> products;

  FilterProduct({this.price, this.isPromo = false, required this.products});
}

final class ResetFilter extends ProductEvent {
  final List<Product> products;

  ResetFilter({required this.products});
}

final class FindCategoryById extends ProductEvent {
  final String id;
  final Product product;

  FindCategoryById({required this.id, required this.product});
}
