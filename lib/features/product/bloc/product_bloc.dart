import 'dart:async';
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
    on<ResetFilter>(resetFilter);
  }

  FutureOr<void> fectchAllProduct(
      FetchAllProduct event, Emitter<ProductState> emit) async {
    final res = await _getAllProduct(NoParams());
    res.fold(
      (l) => emit(ProductFailure(l)),
      (r) => emit(ProductDisplaySuccess(products: r)),
    );
  }

  // for filter
  FutureOr<void> filterProduct(
      FilterProduct event, Emitter<ProductState> emit) {
    List<Product> products = [];
    if (event.isPromo == true) {
      for (var item in event.products) {
        if (item.isPromo == true) {
          products.add(item);
        }
      }
      emit(ProductDisplaySuccess(products: products));
    } else {
      if (event.price == SortType.ascending) {
        event.products.sort((a, b) => a.price.compareTo(b.price));
        emit(ProductDisplaySuccess(products: event.products));
      } else if (event.price == SortType.descending) {
        event.products.sort((a, b) => b.price.compareTo(a.price));
        emit(ProductDisplaySuccess(products: event.products));
      }
    }
  }

  FutureOr<void> resetFilter(
      ResetFilter event, Emitter<ProductState> emit) async {
    emit(ProductDisplaySuccess(products: event.products));
    final res = await _getAllProduct(NoParams());
    res.fold(
      (l) => emit(ProductFailure(l)),
      (r) => emit(ProductDisplaySuccess(products: r)),
    );
  }
}
