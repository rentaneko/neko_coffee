import 'package:neko_coffee/models/category.model.dart';
import 'package:neko_coffee/models/product.model.dart';
import 'package:neko_coffee/models/sub_category.model.dart';

abstract class CategoryState {}

abstract class CategoryActionState extends CategoryState {}

class InitialCategoryState extends CategoryState {}

class LoadingCategoryState extends CategoryState {}

class ErrorCategoryState extends CategoryState {
  final String errorMsg;

  ErrorCategoryState({required this.errorMsg});
}

class LoadingSuccessCategoryState extends CategoryState {
  final List<CategoryModel> cate;
  final List<SubCategoryModel> subCates;
  final List<ProductModel> products;

  LoadingSuccessCategoryState(
      {required this.cate, required this.subCates, required this.products});
}

class LoadingSubCategoryState extends CategoryState {
  final List<CategoryModel> cates;

  LoadingSubCategoryState({required this.cates});
}

class CategoryLoadingProductState extends CategoryState {
  final List<CategoryModel> categories;
  final List<SubCategoryModel> subCategories;

  CategoryLoadingProductState(
      {required this.categories, required this.subCategories});
}

class CategoryLoadedProductState extends CategoryState {}

class SubCategoryClickedState extends CategoryActionState {}
