import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/core/entities/cart.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import 'package:neko_coffee/core/entities/topping.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/usecase/add_to_cart.dart';
import 'package:neko_coffee/domain/usecase/get_list_item_by_id.dart';
import 'package:neko_coffee/domain/usecase/get_topping_by_id.dart';
import 'package:neko_coffee/domain/usecase/update_cart_item.dart';
part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final AddToCart _addToCart;
  final GetListItemCartById _getListItemCartById;
  final UpdateCartItem _updateCartItem;
  final GetToppingById _getToppingById;

  AddToCartBloc({
    required AddToCart addToCart,
    required GetListItemCartById getListItem,
    required UpdateCartItem updateCartItem,
    required GetToppingById getToppingById,
  })  : _addToCart = addToCart,
        _getListItemCartById = getListItem,
        _updateCartItem = updateCartItem,
        _getToppingById = getToppingById,
        super(AddToCartInitialState()) {
    on<InitialAddToCartEvent>(initialAddToCartEvent);
    on<UpdateSizeCupEvent>(updateSizeCupEvent);
    on<UpdateIceTypeEvent>(updateIceTypeEvent);
    on<UpdateSugarTypeEvent>(updateSugarTypeEvent);
    on<UpdateVariantEvent>(updateVariantEvent);
    on<AddItemToCartEvent>(addItemToCartEvent);
  }

  FutureOr<void> initialAddToCartEvent(
      InitialAddToCartEvent event, Emitter<AddToCartState> emit) async {
    emit(AddToCartLoadingState());
    try {
      final result = await _getListItemCartById(
          GetListItemCartParams(idProduct: event.idProduct));
      result.fold((l) => print(l), (r) => cartItem = r);
      final data =
          await _getToppingById(GetToppingByIdParams(id: event.idCate));
      data.fold((l) => l, (r) => toppings = r);
      emit(
        AddToCartDisplaySuccessState(
          iceType: iceType,
          sizeCup: sizeCup,
          sugarType: sugarType,
          variantType: variantType,
          toppings: toppings,
        ),
      );
    } on DioException catch (e) {
      emit(AddToCartFailureState(error: ServerError.handleException(e)));
    }
  }

  String iceType = IceType.normal.name;
  String sugarType = SugarType.normal.name;
  String variantType = VariantType.ice.name;
  String sizeCup = SizeCup.regular.name;
  String idCartItem = '';
  int quantityBefor = 0;
  double total = 0.0;

  List<CartItem> cartItem = [];
  List<Topping> toppings = [];

  FutureOr<void> addItemToCartEvent(
      AddItemToCartEvent event, Emitter<AddToCartState> emit) async {
    try {
      if (checkSameAs()) {
        int quantity = quantityBefor + 1;
        //
        //     final res = await _updateCartItem(
        //       UpdateCartItemParams(
        //         id: idCartItem,
        //         quantity: quantity,
        //         total: event.price * quantity,
        //       ),
        //     );
        //     res.fold(
        //       (l) => emit(AddItemToCartFailureState(error: l)),
        //       (r) => emit(AddToCartSuccessState()),
        //     );

        //
      } else {
        final res = await _addToCart(
          AddToCartParams(
            idProduct: event.idProduct,
            iceType: iceType,
            variantType: variantType,
            sizeCup: sizeCup,
            sugarType: sugarType,
            quantity: 1,
            total: event.price,
          ),
        );

        res.fold(
          (l) => emit(AddItemToCartFailureState(error: l)),
          (r) => emit(AddToCartSuccessState()),
        );
      }
    } on DioException catch (e) {
      emit(AddItemToCartFailureState(error: ServerError.handleException(e)));
    }
  }

  bool checkSameAs() {
    for (var e in cartItem) {
      if (e.variantType == variantType &&
          e.iceType == iceType &&
          e.sugarType == sugarType &&
          e.sizeCup == sizeCup) {
        idCartItem = e.id!;
        quantityBefor = e.quantity;
        return true;
      }
    }
    return false;
  }

  bool listEquals(List<String> list1, List<String> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  FutureOr<void> updateSizeCupEvent(
      UpdateSizeCupEvent event, Emitter<AddToCartState> emit) {
    sizeCup = event.type;
    emit(
      AddToCartDisplaySuccessState(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeCup: sizeCup,
        toppings: toppings,
      ),
    );
  }

  FutureOr<void> updateVariantEvent(
      UpdateVariantEvent event, Emitter<AddToCartState> emit) {
    variantType = event.type;
    emit(
      AddToCartDisplaySuccessState(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeCup: sizeCup,
        toppings: toppings,
      ),
    );
  }

  FutureOr<void> updateSugarTypeEvent(
      UpdateSugarTypeEvent event, Emitter<AddToCartState> emit) {
    sugarType = event.type;
    emit(
      AddToCartDisplaySuccessState(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeCup: sizeCup,
        toppings: toppings,
      ),
    );
  }

  FutureOr<void> updateIceTypeEvent(
      UpdateIceTypeEvent event, Emitter<AddToCartState> emit) {
    iceType = event.type;
    emit(
      AddToCartDisplaySuccessState(
        iceType: iceType,
        sugarType: sugarType,
        variantType: variantType,
        sizeCup: sizeCup,
        toppings: toppings,
      ),
    );
  }
}
