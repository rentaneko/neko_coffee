import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import 'package:neko_coffee/core/entities/product.dart';
import 'package:neko_coffee/core/use_case/usecase.dart';
import 'package:neko_coffee/domain/usecase/get_all_product.dart';

import '../../../core/error/server_error.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetAllProduct _getAllProduct;

  ProductBloc({required GetAllProduct getAllProduct})
      : _getAllProduct = getAllProduct,
        super(ProductInitial()) {
    on<ProductEvent>((event, emit) => emit(ProductLoading()));
    on<FetchAllProduct>(fectchAllProduct);
    on<FilterProduct>(filterProduct);
  }

  FutureOr<void> fectchAllProduct(
      FetchAllProduct event, Emitter<ProductState> emit) async {
    final res = await _getAllProduct(NoParams());
    res.fold(
      (l) => emit(ProductFailure(l)),
      (r) => emit(ProductDisplaySuccess(products: r)),
    );
  }

  FutureOr<void> filterProduct(
      FilterProduct event, Emitter<ProductState> emit) {
    List<Product> products = event.products;
    if (event.price != null && event.isPromo != null) {
      if (event.price == SortType.ascending && event.isPromo == true) {
        // products.sort(
        //   (a, b) {},
        // );
      }
    } else {
      emit(ProductDisplaySuccess(products: products));
    }
  }
}
