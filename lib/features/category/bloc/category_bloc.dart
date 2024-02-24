import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/features/category/bloc/index.dart';
import 'package:neko_coffee/models/category.model.dart';
import 'package:neko_coffee/models/sub_category.model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final client = Supabase.instance.client;
  CategoryBloc(CategoryState initialState) : super(InitialCategoryState()) {
    on<InitialCategoryEvent>(initialCategoryEvent);

    on<CategoryClickedEvent>(categoryClickedEvent);
  }

  FutureOr<void> initialCategoryEvent(
      InitialCategoryEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingCategoryState());
    List<CategoryModel> cates = [];
    List<SubCategoryModel> subCates = [];
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
      emit(LoadingSuccessCategoryState(cate: cates, subCates: subCates));
    } catch (e) {
      emit(ErrorCategoryState(errorMsg: 'Something was wrong'));
    }
  }

  FutureOr<void> categoryClickedEvent(
      CategoryClickedEvent event, Emitter<CategoryState> emit) async {
    emit(LoadingSubCategoryState(cates: event.cates));
    List<SubCategoryModel> subCates = [];
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
      emit(LoadingSuccessCategoryState(cate: event.cates, subCates: subCates));
    } catch (e) {
      emit(ErrorCategoryState(errorMsg: 'Something was wrong'));
    }
  }
}
