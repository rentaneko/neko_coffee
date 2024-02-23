import 'package:flutter/material.dart';
import 'package:neko_coffee/features/home/bloc/home_bloc.dart';

@immutable
abstract class CartEvent {}

class InitialCartEvent extends CartEvent {}

class UpdateQuantityItemCartEvent extends CartEvent {
  final String idProduct;
  final int quantity;
  final HomeBloc homeBloc;

  UpdateQuantityItemCartEvent({
    required this.idProduct,
    required this.quantity,
    required this.homeBloc,
  });
}
