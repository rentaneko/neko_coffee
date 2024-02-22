import 'package:flutter/material.dart';
import 'package:neko_coffee/models/cart.model.dart';

@immutable
abstract class CartEvent {}

class InitialCartEvent extends CartEvent {}

class GetItemInCart extends CartEvent {
  final List<CartModel> cart;

  GetItemInCart({required this.cart});
}
