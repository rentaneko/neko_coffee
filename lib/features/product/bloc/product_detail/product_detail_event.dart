part of 'product_detail_bloc.dart';

@immutable
sealed class ProductDetailEvent {
  const ProductDetailEvent();
}

final class FindCategoryById extends ProductDetailEvent {
  final String id;
  final Product product;
  const FindCategoryById({required this.id, required this.product});
}
