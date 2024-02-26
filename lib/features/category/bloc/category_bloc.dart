import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/category/bloc/index.dart';
import 'package:neko_coffee/models/category.model.dart';
import 'package:neko_coffee/models/product.model.dart';
import 'package:neko_coffee/models/sub_category.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final client = Supabase.instance.client;
  String idSubCategory = '';
  List<CategoryModel> cates = [];
  List<SubCategoryModel> subCates = [];
  List<ProductModel> products = [];

  CategoryBloc(CategoryState initialState) : super(InitialCategoryState()) {
    on<InitialCategoryEvent>(initialCategoryEvent);

    on<CategoryClickedEvent>(categoryClickedEvent);

    on<SubCategoryClickedEvent>(subCategoryClickedEvent);
  }

  FutureOr<void> initialCategoryEvent(
      InitialCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingCategoryState());

    try {
      await client.from('Category').select().eq('is_active', true).then(
            (value) =>
                cates = value.map((e) => CategoryModel.fromJson(e)).toList(),
          );
      await client
          .from('Sub_category')
          .select()
          .eq('is_active', true)
          .eq('id_parent', cates[0].id!)
          .then(
            (value) => subCates =
                value.map((e) => SubCategoryModel.fromJson(e)).toList(),
          );
      idSubCategory = subCates[0].id!;
      await client
          .from('Product')
          .select()
          .eq('id_sub_category', idSubCategory)
          .then((value) =>
              products = value.map((e) => ProductModel.fromJson(e)).toList());

      emit(LoadingSuccessCategoryState(
          cate: cates, subCates: subCates, products: products));
    } catch (e) {
      emit(ErrorCategoryState(errorMsg: 'Something was wrong'));
    }
  }

  FutureOr<void> categoryClickedEvent(
      CategoryClickedEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingSubCategoryState(cates: event.cates));

    try {
      await client
          .from('Sub_category')
          .select()
          .eq('is_active', true)
          .eq('id_parent', event.idParent)
          .then(
            (value) => subCates =
                value.map((e) => SubCategoryModel.fromJson(e)).toList(),
          );
      idSubCategory = subCates[0].id!;
      await client
          .from('Product')
          .select()
          .eq('id_sub_category', idSubCategory)
          .then((value) =>
              products = value.map((e) => ProductModel.fromJson(e)).toList());
      emit(LoadingSuccessCategoryState(
          cate: event.cates, subCates: subCates, products: products));
    } catch (e) {
      emit(ErrorCategoryState(errorMsg: 'Something was wrong'));
    }
  }

  FutureOr<void> subCategoryClickedEvent(
      SubCategoryClickedEvent event, Emitter<CategoryState> emit) async {
    idSubCategory = event.idSubCategory;
    emit(CategoryLoadingProductState(
        categories: cates, subCategories: subCates));
    try {
      await client
          .from('Product')
          .select()
          .eq('id_sub_category', event.idSubCategory)
          .order('name', ascending: true)
          .then((value) =>
              products = value.map((e) => ProductModel.fromJson(e)).toList());
      emit(
        LoadingSuccessCategoryState(
            cate: cates, products: products, subCates: subCates),
      );
    } catch (e) {
      emit(ErrorCategoryState(errorMsg: e.toString()));
    }
  }
}
