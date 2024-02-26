import 'package:flutter/material.dart';

@immutable
abstract class ProductDetailEvent {}

class ProductDetailInitialEvent extends ProductDetailEvent {
  final String idProduct;

  ProductDetailInitialEvent({required this.idProduct});
}
