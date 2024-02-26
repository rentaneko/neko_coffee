import 'package:flutter/widgets.dart';
import 'package:neko_coffee/models/category.model.dart';

import '../../../models/product.model.dart';

@immutable
abstract class CategoryEvent {}

class InitialCategoryEvent extends CategoryEvent {}

class CategoryClickedEvent extends CategoryEvent {
  final String idParent;
  final List<CategoryModel> cates;

  CategoryClickedEvent({required this.idParent, required this.cates});
}

class CategoryLoadedProductEvent extends CategoryEvent {
  final List<ProductModel> product;

  CategoryLoadedProductEvent({required this.product});
}

class SubCategoryClickedEvent extends CategoryEvent {
  final String idSubCategory;

  SubCategoryClickedEvent({required this.idSubCategory});
}
