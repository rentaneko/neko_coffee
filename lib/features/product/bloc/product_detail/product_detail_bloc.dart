import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/core/entities/category.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/error/server_error.dart';

import '../../../../domain/usecase/get_category_by_id.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetCategoryById _getCategoryById;
  ProductDetailBloc({required GetCategoryById getCategoryById})
      : _getCategoryById = getCategoryById,
        super(LoadingProductDetailState()) {
    on<FindCategoryById>(findCategoryById);
  }

  FutureOr<void> findCategoryById(
      FindCategoryById event, Emitter<ProductDetailState> emit) async {
    final res = await _getCategoryById(GetCategoryByIdParams(id: event.id));
    res.fold(
      (l) => emit(ErrorPoductDetailState(error: l)),
      (r) =>
          emit(DisplayPoductDetailState(product: event.product, category: r)),
    );
  }
}
