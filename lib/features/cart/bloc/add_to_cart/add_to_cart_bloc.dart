import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neko_coffee/core/entities/enum.entity.dart';
import 'package:neko_coffee/core/error/server_error.dart';
import 'package:neko_coffee/domain/usecase/get_topping_by_id.dart';
import '../../../../core/entities/topping.dart';
part 'add_to_cart_event.dart';
part 'add_to_cart_state.dart';

class AddToCartBloc extends Bloc<AddToCartEvent, AddToCartState> {
  final GetToppingById _getToppingById;

  AddToCartBloc({required GetToppingById getToppingById})
      : _getToppingById = getToppingById,
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
      final res = await _getToppingById(GetToppingByIdParams(id: event.id));

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
    for (var e in toppings) {
      print(e.value);
    }
  }
}
