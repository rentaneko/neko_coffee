import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:neko_coffee/core/entities/cart.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/usecase/add_to_cart.dart';
import 'package:neko_coffee/domain/usecase/get_list_item_by_id.dart';
import 'package:neko_coffee/domain/usecase/get_topping_by_id.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/entities/topping.dart';
import '../../../../domain/models/product.model.dart';
part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final GetToppingById _getToppingById;
  final AddToCart _addToCart;
  final GetListItemCartById _getListItemCartById;

  AddToCartBloc(
      {required GetToppingById getToppingById,
      required AddToCart addToCart,
      required GetListItemCartById getListItem})
      : _getToppingById = getToppingById,
        _addToCart = addToCart,
        _getListItemCartById = getListItem,
        super(AddToCartInitial()) {
    on<InitialAddToCartEvent>(initialAddToCartEvent);
    on<UpdateSizeCupEvent>(updateSizeCupEvent);
    on<UpdateIceTypeEvent>(updateIceTypeEvent);
    on<UpdateSugarTypeEvent>(updateSugarTypeEvent);
    on<UpdateVariantEvent>(updateVariantEvent);
    on<AddItemToCartEvent>(addItemToCartEvent);
  }

  FutureOr<void> initialAddToCartEvent(
      InitialAddToCartEvent event, Emitter<AddToCartState> emit) async {
    emit(AddToCartLoading());
    try {
      final res = await _getToppingById(GetToppingByIdParams(id: event.idCate));
      final result = await _getListItemCartById(
          GetListItemCartParams(idProduct: event.idProduct));
      result.fold((l) => print(l), (r) => cartItem = r);
      res.fold(
        (l) => emit(AddToCartFailure(error: l)),
        (r) {
          emit(AddToCartDisplaySuccess(
            toppings: r,
            iceType: iceType,
            sizeType: sizeType,
            sugarType: sugarType,
            variantType: variantType,
          ));
          toppings = r;
        },
      );
    } on DioException catch (e) {
      emit(AddToCartFailure(error: ServerError.handleException(e)));
    }
  }

  String iceType = IceType.normal.name;
  String sugarType = SugarType.normal.name;
  String variantType = VariantType.ice.name;
  String sizeType = SizeCup.regular.name;
  List<Topping> toppings = [];
  List<CartItem> cartItem = [];
  FutureOr<void> updateSizeCupEvent(
      UpdateSizeCupEvent event, Emitter<AddToCartState> emit) {
    sizeType = event.type;
    emit(
      AddToCartDisplaySuccess(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeType: sizeType,
        toppings: toppings,
      ),
    );
  }

  FutureOr<void> updateVariantEvent(
      UpdateVariantEvent event, Emitter<AddToCartState> emit) {
    variantType = event.type;
    emit(
      AddToCartDisplaySuccess(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeType: sizeType,
        toppings: toppings,
      ),
    );
  }

  FutureOr<void> updateSugarTypeEvent(
      UpdateSugarTypeEvent event, Emitter<AddToCartState> emit) {
    sugarType = event.type;
    emit(
      AddToCartDisplaySuccess(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeType: sizeType,
        toppings: toppings,
      ),
    );
  }

  FutureOr<void> updateIceTypeEvent(
      UpdateIceTypeEvent event, Emitter<AddToCartState> emit) {
    iceType = event.type;
    emit(
      AddToCartDisplaySuccess(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeType: sizeType,
        toppings: toppings,
      ),
    );
  }

  FutureOr<void> addItemToCartEvent(
      AddItemToCartEvent event, Emitter<AddToCartState> emit) async {
    try {
      List<String> tmp = [];
      for (var top in toppings) {
        if (top.value == true) {
          tmp.add(top.id);
        }
      }

      // final res = await _addToCart(
      //   AddToCartParams(
      //     idProduct: event.idProduct,
      //     idTopping: tmp,
      //     iceType: iceType,
      //     variantType: variantType,
      //     sizeCup: sizeType,
      //     sugarType: sugarType,
      //     quantity: 1,
      //     id: const Uuid().v4().trim(),
      //   ),
      // );

      // res.fold(
      //     (l) => print(l.error), (r) => print('SUCCESS ----------------- $r'));
    } on DioException catch (e) {
      emit(AddItemToCartFailure(error: ServerError.handleException(e)));
    }
  }
}
